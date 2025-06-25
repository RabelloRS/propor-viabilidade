#!/bin/bash

# Script de configuração do servidor para o site da Propor Engenharia
# Execute este script como root no servidor VPS

echo "🚀 Configurando servidor para o site da Propor Engenharia..."

# Atualizar sistema
echo "📦 Atualizando sistema..."
apt update
apt upgrade -y

# Instalar dependências
echo "🔧 Instalando dependências..."
apt install -y nginx git curl unzip

# Criar diretório do site
echo "📁 Criando diretório do site..."
mkdir -p /var/www/propor
chown -R www-data:www-data /var/www/propor
chmod -R 755 /var/www/propor

# Configurar Nginx
echo "⚙️ Configurando Nginx..."
cat > /etc/nginx/sites-available/propor << 'EOF'
server {
    listen 80;
    server_name 85.209.93.171;
    root /var/www/propor;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }

    # Configurações de segurança
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;
    add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;

    # Cache para arquivos estáticos
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|pdf)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_proxied expired no-cache no-store private must-revalidate auth;
    gzip_types text/plain text/css text/xml text/javascript application/x-javascript application/xml+rss;
}
EOF

# Ativar site
ln -sf /etc/nginx/sites-available/propor /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Testar configuração do Nginx
nginx -t

# Reiniciar Nginx
systemctl restart nginx
systemctl enable nginx

# Configurar firewall
echo "🔥 Configurando firewall..."
ufw allow 'Nginx Full'
ufw allow OpenSSH
ufw --force enable

echo "✅ Servidor configurado com sucesso!"
echo "🌐 Site será acessível em: http://85.209.93.171"
echo ""
echo "📋 Próximos passos:"
echo "1. Faça upload dos arquivos do site para /var/www/propor/"
echo "2. Verifique se o site está funcionando"
echo "3. Configure SSL/HTTPS se necessário" 