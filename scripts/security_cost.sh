#!/usr/bin/env bash

# Definir colores para la salida
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Función para imprimir secciones
print_section() {
  echo "${YELLOW}================================================================================${NC}"
  echo "${GREEN}$1${NC}"
  echo "${YELLOW}================================================================================${NC}"
}

# Ejecutar tfsec y capturar la salida
print_section "Ejecutando tfsec para revisar la configuración de seguridad de Terraform"
if command -v tfsec &>/dev/null; then
    tfsec_output=$(tfsec .)
    echo "$tfsec_output"
else
    echo "${RED}Error: tfsec no está instalado. Instálalo para continuar con esta evaluación.${NC}"
fi

# Dejar espacio entre las salidas
echo "\n\n"

# Ejecutar infracost y capturar la salida
print_section "Ejecutando infracost para estimar los costos de la infraestructura de Terraform"
if command -v infracost &>/dev/null; then
    infracost_output=$(infracost breakdown --path=. --format table)
    echo "$infracost_output"
else
    echo "${RED}Error: infracost no está instalado. Instálalo para continuar con esta estimación.${NC}"
fi

