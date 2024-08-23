#!/usr/bin/env bash

# Función para verificar si un comando está disponible en el sistema
check_and_install() {
  local tool=$1
  local url=$2

  # Verificar si el comando ya está instalado
  if ! command -v $tool &> /dev/null
  then
    echo "$tool no está instalado. Instalando..."
    # Descargar e instalar la herramienta
    curl -fsSL $url | sh
    echo "$tool instalado exitosamente."
  else
    echo "$tool ya está instalado."
  fi
}

# URL para el script de instalación de infracost
infracost_url="https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh"
# URL para el script de instalación de tfsec
tfsec_url="https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh"

# Verificar e instalar infracost
check_and_install "infracost" "$infracost_url"

# Verificar e instalar tfsec
check_and_install "tfsec" "$tfsec_url"
