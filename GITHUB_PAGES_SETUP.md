# 🚀 Guia de Configuração do GitHub Pages

## ❌ **Problema Atual**
Você está recebendo erro 404 no GitHub Pages porque a configuração não está ativada corretamente.

## ✅ **Solução Passo a Passo**

### **Passo 1: Configurar GitHub Pages no Repositório**

1. **Acesse seu repositório no GitHub**
   - Vá para: `https://github.com/rabellors/propor-viabilidade`

2. **Vá para Settings**
   - Clique na aba "Settings" (Configurações)

3. **Encontre GitHub Pages**
   - No menu lateral esquerdo, clique em "Pages"

4. **Configure a Source**
   - Em "Source", selecione: **"GitHub Actions"**
   - Isso permitirá que o workflow que criamos funcione

### **Passo 2: Verificar Configurações**

Certifique-se de que:
- ✅ O repositório é público (ou você tem GitHub Pro)
- ✅ O branch principal é `main`
- ✅ O workflow está no diretório `.github/workflows/`

### **Passo 3: Fazer Push das Alterações**

```bash
# Adicionar as alterações
git add .

# Fazer commit
git commit -m "Configurar GitHub Pages com workflow atualizado"

# Fazer push
git push origin main
```

### **Passo 4: Verificar o Deploy**

1. **Vá para a aba "Actions"**
   - Clique em "Actions" no seu repositório
   - Você verá o workflow "Deploy to GitHub Pages" rodando

2. **Aguarde o deploy**
   - O processo leva alguns minutos
   - Status verde = sucesso

3. **Acesse o site**
   - URL: `https://rabellors.github.io/propor-viabilidade`

---

## 🔧 **Arquivos Importantes**

### **Workflow Atualizado** (`.github/workflows/deploy.yml`)
```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout
      uses: actions/checkout@v4
      
    - name: Setup Pages
      uses: actions/configure-pages@v4
      
    - name: Upload artifact
      uses: actions/upload-pages-artifact@v3
      with:
        path: '.'
        
    - name: Deploy to GitHub Pages
      id: deployment
      uses: actions/deploy-pages@v4
```

### **Arquivo .nojekyll**
- Indica que não é um site Jekyll
- Permite servir arquivos HTML estáticos

---

## 🌐 **URLs Finais**

Após o deploy bem-sucedido:

- **Site Principal**: `https://rabellors.github.io/propor-viabilidade`
- **Página Inicial**: `https://rabellors.github.io/propor-viabilidade/index.html`
- **Estudo de Viabilidade**: `https://rabellors.github.io/propor-viabilidade/viabilidade.html`
- **Análise de Zoneamento**: `https://rabellors.github.io/propor-viabilidade/link_zoneamento.html`

---

## 🛠️ **Troubleshooting**

### **Se ainda der erro 404:**

1. **Verifique as Actions**
   - Vá em Actions → Deploy to GitHub Pages
   - Veja se há erros no log

2. **Verifique as permissões**
   - Settings → Actions → General
   - Certifique-se que "Actions permissions" está em "Allow all actions"

3. **Verifique o branch**
   - Certifique-se que está fazendo push para `main`

### **Se o site não carregar:**

1. **Limpe o cache do navegador**
2. **Aguarde alguns minutos** (propagação do DNS)
3. **Teste em modo incógnito**

---

## 📞 **Suporte**

Se ainda tiver problemas:

1. **Verifique os logs** na aba Actions
2. **Confirme as configurações** em Settings → Pages
3. **Teste localmente** abrindo o `index.html` no navegador

---

**🎉 Após seguir estes passos, seu site estará funcionando no GitHub Pages!** 