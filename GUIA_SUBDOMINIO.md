# 🌐 Guia de Configuração do Subdomínio

## 📋 Configuração do Subdomínio: viabilidade.propor.net

### 🎯 **Objetivo**
Criar um subdomínio específico para o site de viabilidade da Propor Engenharia, mantendo o domínio principal `propor.net` funcionando normalmente.

---

## 🔧 **Passo 1: Configurar DNS**

### No seu provedor de DNS (onde está registrado propor.net):

1. **Acesse o painel de controle do DNS**
2. **Adicione um novo registro A:**
   ```
   Tipo: A
   Nome: viabilidade
   Valor: 85.209.93.171
   TTL: 300 (ou padrão)
   ```

3. **Ou adicione um registro CNAME:**
   ```
   Tipo: CNAME
   Nome: viabilidade
   Valor: propor.net
   TTL: 300 (ou padrão)
   ```

### ⏱️ **Tempo de Propagação**
- Pode levar de 5 minutos a 24 horas
- Teste com: `nslookup viabilidade.propor.net`

---

## 🖥️ **Passo 2: Configurar o Servidor**

### Conectar via SSH:
```bash
ssh root@85.209.93.171
```

### Executar o script de configuração:
```bash
# Copie e cole o conteúdo do arquivo subdomain_config.sh
nano subdomain_config.sh
# Cole o conteúdo e salve (Ctrl+X, Y, Enter)

# Torne o script executável
chmod +x subdomain_config.sh

# Execute o script
./subdomain_config.sh
```

---

## 📁 **Passo 3: Upload dos Arquivos**

### Opção A: SCP (do seu computador)
```bash
# No PowerShell, execute:
scp -r *.html *.jpg *.ico *.pdf root@85.209.93.171:/var/www/viabilidade.propor.net/
```

### Opção B: SFTP (FileZilla/WinSCP)
1. Conecte em: `sftp://root@85.209.93.171`
2. Navegue para: `/var/www/viabilidade.propor.net/`
3. Faça upload de todos os arquivos

### Opção C: Git (se tiver repositório)
```bash
# No servidor:
cd /var/www/viabilidade.propor.net
git clone [URL_DO_REPOSITORIO] .
```

---

## 🔒 **Passo 4: Configurar SSL (Se Necessário)**

### Se o certificado wildcard não funcionar:
```bash
# Instalar Certbot
apt install -y certbot python3-certbot-nginx

# Obter certificado para o subdomínio
certbot --nginx -d viabilidade.propor.net
```

---

## 🧪 **Passo 5: Testar**

### Verificar configuração:
```bash
# Testar configuração do Nginx
nginx -t

# Verificar se o site está acessível
curl -I https://viabilidade.propor.net
```

### Testar no navegador:
1. Acesse: `https://viabilidade.propor.net`
2. Verifique se todas as páginas funcionam:
   - Página inicial
   - Estudo de viabilidade
   - Análise de zoneamento

---

## 📊 **Monitoramento**

### Verificar logs:
```bash
# Logs de acesso
tail -f /var/log/nginx/viabilidade.propor.net.access.log

# Logs de erro
tail -f /var/log/nginx/viabilidade.propor.net.error.log
```

### Verificar status:
```bash
# Status do Nginx
systemctl status nginx

# Verificar se o diretório existe
ls -la /var/www/viabilidade.propor.net/
```

---

## 🛠️ **Comandos Úteis**

```bash
# Reiniciar Nginx
systemctl reload nginx

# Verificar configuração
nginx -t

# Verificar permissões
chown -R www-data:www-data /var/www/viabilidade.propor.net
chmod -R 755 /var/www/viabilidade.propor.net

# Verificar DNS
nslookup viabilidade.propor.net
dig viabilidade.propor.net
```

---

## 🎯 **URLs Finais**

- **Subdomínio Principal**: `https://viabilidade.propor.net`
- **Página Inicial**: `https://viabilidade.propor.net/index.html`
- **Estudo de Viabilidade**: `https://viabilidade.propor.net/viabilidade.html`
- **Análise de Zoneamento**: `https://viabilidade.propor.net/link_zoneamento.html`

---

## 🔄 **Estrutura Final**

```
propor.net (domínio principal)
├── App principal (porta 8501)
└── viabilidade.propor.net (subdomínio)
    ├── index.html
    ├── viabilidade.html
    ├── link_zoneamento.html
    └── assets (imagens, CSS, JS)
```

---

## ✅ **Checklist de Verificação**

- [ ] DNS configurado (viabilidade.propor.net → 85.209.93.171)
- [ ] Script de configuração executado
- [ ] Arquivos do site enviados para `/var/www/viabilidade.propor.net/`
- [ ] Permissões corretas (www-data:www-data, 755)
- [ ] SSL funcionando (https://viabilidade.propor.net)
- [ ] Todas as páginas acessíveis
- [ ] Links internos funcionando
- [ ] Imagens carregando corretamente

---

**🎉 Subdomínio configurado com sucesso!** 