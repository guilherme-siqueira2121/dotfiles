#!/bin/bash
# restore-backup.sh
# Restaura backup em caso de problemas

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Backups disponíveis:${NC}"
ls -lt ~/.config-backup-* 2>/dev/null | head -5

echo ""
read -p "Digite o nome completo do backup para restaurar: " backup_name

if [ ! -d "$backup_name" ]; then
    echo -e "${RED}Backup não encontrado!${NC}"
    exit 1
fi

echo -e "${YELLOW}Restaurando de: $backup_name${NC}"

for config in "$backup_name"/*; do
    config_name=$(basename "$config")
    rm -rf "$HOME/.config/$config_name"
    cp -r "$config" "$HOME/.config/"
    echo -e "${GREEN}✓ Restaurado: $config_name${NC}"
done

echo -e "${GREEN}Restauração concluída!${NC}"
