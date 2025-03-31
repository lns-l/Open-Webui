# 🧠 Ollama + Open WebUI (Docker Compose)

Este repositório contém dois serviços Docker Compose separados para executar o modelo Ollama com uma interface web (Open WebUI), mantendo volumes e ambientes isolados.

---

## 📦 Estrutura do Projeto

```
.
├── docker-compose.ollama.yml
├── docker-compose.webui.yml
├── Dockerfile
├── Makefile
├── data/
│   ├── ollama/
│   └── open-webui/
└── README.md
```

---

## 🚀 Como usar

### Pré-requisitos

- Docker
- Docker Compose
- `make` (opcional, mas recomendado)

### Subindo os serviços

Para subir os dois containers:

```bash
make up
```

Ou manualmente:

```bash
docker-compose -f docker-compose.ollama.yml up -d
docker-compose -f docker-compose.webui.yml up -d
```

> Certifique-se de que o serviço `ollama` esteja rodando antes do `open-webui`.

---

### Parando os serviços

```bash
make down
```

---

### Reiniciando os serviços

```bash
make restart
```

---

### Logs

```bash
make logs
```

---

## 📁 Volumes e dados

- Dados do Ollama: `./data/ollama`
- Dados da Open WebUI: `./data/open-webui`

Esses diretórios armazenam os dados persistentes de cada serviço.

---

## ⚙️ Variáveis de ambiente

Você pode definir variáveis como `OPEN_WEBUI_PORT` e `WEBUI_DOCKER_TAG` via `.env` ou diretamente no ambiente.

---

## 🧩 Personalizações

O serviço `open-webui` usa um `Dockerfile` customizado. Altere conforme necessário.

---

## 🧼 Limpeza

Para remover containers e volumes:

```bash
make down
docker volume prune
```

---

## 📚 Licença

Este projeto está sob a [MIT License](LICENSE).
