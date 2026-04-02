#!/bin/bash
# =====================================================
# setup-symlinks.sh - Setup inicial de symlinks
# Lê automaticamente pastas em config/ e cria symlinks
# =====================================================

DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$DOTFILES_DIR/config"

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Contadores
SUCCESS=0
FAILED=0
SKIPPED=0

# Pastas a ignorar (não criar symlinks)
IGNORE_DIRS=("docs" "backups" "cache" "logs" "sddm")

# Função de notificação
notify() {
    local title="$1"
    local message="$2"
    local urgency="${3:-normal}"

    if command -v notify-send &> /dev/null; then
        notify-send -u "$urgency" "$title" "$message"
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

echo -e "${BLUE}=========================================="
echo "  Setup Automático de Symlinks"
echo "==========================================${NC}"
echo ""

# Verificar se dotfiles existe
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${RED}Erro: Pasta ~/dotfiles não encontrada!${NC}"
    notify "Erro" "Pasta ~/dotfiles não encontrada!" "critical"
    exit 1
fi

if [ ! -d "$CONFIG_DIR" ]; then
    echo -e "${RED}Erro: Pasta ~/dotfiles/config não encontrada!${NC}"
    notify "Erro" "Pasta config/ não encontrada!" "critical"
    exit 1
fi

# Confirmar ação
echo -e "${YELLOW}Este script vai:${NC}"
echo "1. Fazer backup das configs atuais"
echo "2. Criar symlinks para todas as pastas em config/"
echo "3. Ignorar: ${IGNORE_DIRS[*]}"
echo ""
read -p "Continuar? (s/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Ss]$ ]]; then
    echo "Operação cancelada."
    exit 0
fi

# Criar backup
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
echo -e "${GREEN}Criando backup em: $BACKUP_DIR${NC}"
mkdir -p "$BACKUP_DIR"

# Detectar automaticamente todas as pastas em config/
echo -e "${BLUE}Detectando configurações...${NC}"
CONFIGS=()
for dir in "$CONFIG_DIR"/*; do
    [ -d "$dir" ] || continue
    config_name=$(basename "$dir")

    # Pular pastas ignoradas
    if should_ignore "$config_name"; then
        echo -e "${YELLOW}⊘ Ignorando: $config_name${NC}"
        ((SKIPPED++))
        continue
    fi

    CONFIGS+=("$config_name")
done

echo -e "${BLUE}Encontradas ${#CONFIGS[@]} configurações${NC}"
echo ""

# Processar cada config
for config in "${CONFIGS[@]}"; do
    echo -e "${BLUE}Processando: $config${NC}"

    SRC="$CONFIG_DIR/$config"
    DEST="$HOME/.config/$config"

    # Fazer backup se existir e não for symlink
    if [ -e "$DEST" ]; then
        if [ ! -L "$DEST" ]; then
            if mv "$DEST" "$BACKUP_DIR/"; then
                echo -e "  ${GREEN}✓${NC} Backup feito"
            else
                echo -e "  ${RED}✗${NC} Falha no backup"
                ((FAILED++))
                continue
            fi
        else
            rm "$DEST"
            echo -e "  ${YELLOW}⟳${NC} Symlink antigo removido"
        fi
    fi

    # Criar symlink
    if ln -s "$SRC" "$DEST" 2>/dev/null; then
        echo -e "  ${GREEN}✓ Symlink criado: ~/.config/$config${NC}"
        ((SUCCESS++))
    else
        echo -e "  ${RED}✗ Falha ao criar symlink${NC}"
        ((FAILED++))
    fi
done

# SDDM (requer sudo)
echo ""
echo -e "${YELLOW}Configurando SDDM...${NC}"
if [ -d "$DOTFILES_DIR/config/sddm" ]; then
    if sudo mkdir -p /etc/sddm.conf.d && \
       sudo cp "$DOTFILES_DIR/config/sddm/"*.conf /etc/sddm.conf.d/ 2>/dev/null; then
        echo -e "${GREEN}✓ Configs do SDDM copiadas${NC}"
    fi
fi

if [ -d "$DOTFILES_DIR/themes/sddm-silent" ]; then
    if sudo cp -r "$DOTFILES_DIR/themes/sddm-silent" /usr/share/sddm/themes/silent 2>/dev/null; then
        echo -e "${GREEN}✓ Tema SDDM instalado${NC}"
    fi
fi

# Resumo final
echo ""
echo -e "${GREEN}=========================================="
echo "  Setup Concluído!"
echo "==========================================${NC}"
echo ""
echo "Estatísticas:"
echo -e "  ${GREEN}✓ Sucesso: $SUCCESS${NC}"
echo -e "  ${RED}✗ Falhas: $FAILED${NC}"
echo -e "  ${YELLOW}⊘ Ignorados: $SKIPPED${NC}"
echo ""
echo "Backup salvo em: $BACKUP_DIR"
echo ""

# Notificação final
if [ $FAILED -eq 0 ]; then
    notify "Dotfiles" "Setup concluído!\n✓ $SUCCESS symlinks criados" "normal"
else
    notify "Dotfiles" "Setup concluído com erros\n✓ $SUCCESS | ✗ $FAILED" "critical"
fi

echo "Próximos passos:"
echo "1. Recarregue: hyprctl reload && pkill waybar && waybar &"
echo "2. Use './sync-dotfiles.sh' para futuras atualizações"
