#!/bin/bash
# =====================================================
# sync-dotfiles.sh - Sincronização de symlinks existentes
# Atualiza apenas symlinks que já existem
# =====================================================

DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$DOTFILES_DIR/config"

# Contadores
UPDATED=0
CREATED=0
UNCHANGED=0
FAILED=0

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Pastas a ignorar
IGNORE_DIRS=("docs" "backups" "cache" "logs" "sddm")

# Função de notificação
notify() {
    local title="$1"
    local message="$2"
    if command -v notify-send &> /dev/null; then
        notify-send "$title" "$message"
    fi
}

# Função para verificar se deve ignorar
should_ignore() {
    local dir_name="$1"
    for ignore in "${IGNORE_DIRS[@]}"; do
        [[ "$dir_name" == "$ignore" ]] && return 0
    done
    return 1
}

# Função para criar/atualizar link
sync_link() {
    local src="$1"
    local dest="$2"
    local config_name="$3"

    # Verifica se já é o symlink correto
    if [ -L "$dest" ] && [ "$(readlink -f "$dest")" = "$src" ]; then
        ((UNCHANGED++))
        return 0
    fi

    # Remove se existir (backup automático se não for symlink)
    if [ -e "$dest" ]; then
        if [ ! -L "$dest" ]; then
            # Fazer backup antes de remover
            local backup_name="${dest}.backup-$(date +%Y%m%d-%H%M%S)"
            if mv "$dest" "$backup_name"; then
                echo -e "${YELLOW}[BACKUP]${NC} $config_name -> $backup_name"
            fi
        else
            rm "$dest"
        fi
    fi

    # Criar symlink
    mkdir -p "$(dirname "$dest")"
    if ln -s "$src" "$dest" 2>/dev/null; then
        if [ -e "$dest" ] && [ -L "$dest" ]; then
            echo -e "${GREEN}[ATUALIZADO]${NC} $config_name"
            ((UPDATED++))
        else
            echo -e "${GREEN}[CRIADO]${NC} $config_name"
            ((CREATED++))
        fi
        return 0
    else
        echo -e "${RED}[ERRO]${NC} $config_name"
        ((FAILED++))
        return 1
    fi
}

echo -e "${BLUE}==================================="
echo "  Sincronizando Dotfiles"
echo "===================================${NC}"
echo ""

# Verificar se dotfiles existe
if [ ! -d "$CONFIG_DIR" ]; then
    echo -e "${RED}Erro: Pasta config/ não encontrada!${NC}"
    notify "Erro" "Pasta config/ não encontrada!"
    exit 1
fi

# Sincronizar cada config
for config in "$CONFIG_DIR"/*; do
    [ -d "$config" ] || continue

    config_name=$(basename "$config")

    # Pular ignoradas
    should_ignore "$config_name" && continue

    src="$config"
    dest="$HOME/.config/$config_name"

    sync_link "$src" "$dest" "$config_name"
done

# Recarregar serviços
echo ""
echo -e "${BLUE}=== Recarregando Serviços ===${NC}"

if command -v hyprctl &> /dev/null; then
    if hyprctl reload 2>/dev/null; then
        echo -e "${GREEN}✓${NC} Hyprland recarregado"
    fi
fi

if pgrep -x waybar > /dev/null; then
    pkill waybar 2>/dev/null
    sleep 0.5
    waybar &> /dev/null &
    echo -e "${GREEN}✓${NC} Waybar reiniciada"
fi

# Resumo
echo ""
echo -e "${GREEN}=== Sincronização Concluída ===${NC}"
echo "Criados: $CREATED | Atualizados: $UPDATED | Inalterados: $UNCHANGED | Erros: $FAILED"

# Notificação
if [ $CREATED -gt 0 ] || [ $UPDATED -gt 0 ]; then
    notify "Dotfiles" "✓ Criados: $CREATED | ⟳ Atualizados: $UPDATED"
elif [ $FAILED -gt 0 ]; then
    notify "Dotfiles" "Erros: $FAILED"
else
    notify "Dotfiles" "Nenhuma alteração necessária"
fi
