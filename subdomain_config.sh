#!/bin/bash

# Script para configurar subdomínio viabilidade.propor.net
# Execute como root no servidor VPS

echo "🚀 Configurando subdomínio viabilidade.propor.net..."

# Criar diretório para o subdomínio
echo "📁 Criando diretório do subdomínio..."
mkdir -p /var/www/viabilidade.propor.net
chown -R www-data:www-data /var/www/viabilidade.propor.net
chmod -R 755 /var/www/viabilidade.propor.net

# Configurar Nginx para o subdomínio
echo "⚙️ Configurando Nginx para o subdomínio..."
cat > /etc/nginx/sites-available/viabilidade.propor.net << 'EOF'
# Configuração para viabilidade.propor.net

# Redirecionar HTTP para HTTPS
server {
    listen 80;
    server_name viabilidade.propor.net;
    return 301 https://$host$request_uri;
}

# Servir em HTTPS
server {
    listen 443 ssl;
    server_name viabilidade.propor.net;

    # Usar certificado wildcard ou específico
    ssl_certificate     /etc/letsencrypt/live/propor.net/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/propor.net/privkey.pem;

    # Configurações de segurança SSL
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384;
    ssl_prefer_server_ciphers off;

    # Diretório raiz do site
    root /var/www/viabilidade.propor.net;
    index index.html;

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

    # Configuração principal
    location / {
        try_files $uri $uri/ =404;
    }

    # Logs específicos para o subdomínio
    access_log /var/log/nginx/viabilidade.propor.net.access.log;
    error_log /var/log/nginx/viabilidade.propor.net.error.log;
}
EOF

# Ativar o site
echo "🔗 Ativando configuração do subdomínio..."
ln -sf /etc/nginx/sites-available/viabilidade.propor.net /etc/nginx/sites-enabled/

# Testar configuração do Nginx
echo "🧪 Testando configuração do Nginx..."
nginx -t

if [ $? -eq 0 ]; then
    echo "✅ Configuração do Nginx válida!"
    
    # Reiniciar Nginx
    echo "🔄 Reiniciando Nginx..."
    systemctl reload nginx
    
    echo "✅ Subdomínio configurado com sucesso!"
    echo "🌐 Acessível em: https://viabilidade.propor.net"
    echo ""
    echo "📋 Próximos passos:"
    echo "1. Configure o DNS para apontar viabilidade.propor.net para 85.209.93.171"
    echo "2. Faça upload dos arquivos do site para /var/www/viabilidade.propor.net/"
    echo "3. Teste o acesso ao subdomínio"
else
    echo "❌ Erro na configuração do Nginx!"
    exit 1
fi 