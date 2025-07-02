FROM mcr.microsoft.com/playwright:v1.44.0-jammy

# Instala Chrome estable
RUN apt-get update && apt-get install -y wget gnupg ca-certificates \
  && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update && apt-get install -y google-chrome-stable

# Crea la carpeta de políticas
RUN mkdir -p /etc/opt/chrome/policies/managed

# Copia la política de certificado automático
COPY auto_cert_policy.json /etc/opt/chrome/policies/managed/auto_cert_policy.json

# Copia tu certificado PFX
COPY certificado.pfx /usr/local/share/ca-certificates/certificado.pfx
