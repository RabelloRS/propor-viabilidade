# 🚀 Guia de Deploy - Site Propor Engenharia

## 📋 Pré-requisitos
- Acesso SSH ao servidor VPS (85.209.93.171)
- Senha: `Proporengenharia@2021`

## 🔧 Passo 1: Configurar o Servidor

### Conectar via SSH:
```bash
ssh root@85.209.93.171
```

### Executar o script de configuração:
```bash
# Copie e cole o conteúdo do arquivo setup_server.sh
nano setup_server.sh
# Cole o conteúdo e salve (Ctrl+X, Y, Enter)

# Torne o script executável
chmod +x setup_server.sh

# Execute o script
./setup_server.sh
```

## 📁 Passo 2: Upload dos Arquivos

### Opção A: Usando SCP (do seu computador local)
```bash
# No seu computador (PowerShell), execute:
scp -r . root@85.209.93.171:/var/www/propor/
```

### Opção B: Usando Git (no servidor)
```bash
# No servidor VPS:
cd /var/www/propor
git clone [URL_DO_SEU_REPOSITORIO] .
```

### Opção C: Upload manual via SFTP
1. Use um cliente SFTP (FileZilla, WinSCP)
2. Conecte em: `sftp://root@85.209.93.171`
3. Navegue para `/var/www/propor/`
4. Faça upload de todos os arquivos

## 📄 Passo 3: Verificar Permissões

```bash
# No servidor VPS:
chown -R www-data:www-data /var/www/propor
chmod -R 755 /var/www/propor
```

## 🌐 Passo 4: Testar o Site

1. Abra o navegador
2. Acesse: `http://85.209.93.171`
3. Verifique se todas as páginas estão funcionando:
   - Página inicial
   - Estudo de viabilidade
   - Análise de zoneamento

## 🔒 Passo 5: Configurar SSL (Opcional)

### Instalar Certbot:
```bash
apt install -y certbot python3-certbot-nginx
```

### Obter certificado SSL:
```bash
certbot --nginx -d seu-dominio.com
```

## 📊 Monitoramento

### Verificar status do Nginx:
```bash
systemctl status nginx
```

### Ver logs de erro:
```bash
tail -f /var/log/nginx/error.log
```

### Ver logs de acesso:
```bash
tail -f /var/log/nginx/access.log
```

## 🛠️ Comandos Úteis

```bash
# Reiniciar Nginx
systemctl restart nginx

# Recarregar configuração do Nginx
nginx -s reload

# Verificar configuração do Nginx
nginx -t

# Verificar espaço em disco
df -h

# Verificar uso de memória
free -h
```

## 📞 Suporte

Se encontrar problemas:
1. Verifique os logs do Nginx
2. Confirme que as permissões estão corretas
3. Teste se o Nginx está rodando
4. Verifique se a porta 80 está aberta no firewall

## 🎯 URLs do Site

- **Página Principal**: http://85.209.93.171
- **Estudo de Viabilidade**: http://85.209.93.171/viabilidade.html
- **Análise de Zoneamento**: http://85.209.93.171/link_zoneamento.html

---

**✅ Site da Propor Engenharia pronto para produção!** 