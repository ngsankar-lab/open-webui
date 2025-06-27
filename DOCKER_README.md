# 🚀 LZB AI Platform

> A customized Open WebUI deployment with LZB branding and enhanced features

LZB AI Platform is a self-hosted AI interface that provides a ChatGPT-style experience while maintaining full control over your data and customizations.

## ✨ Features

- 🎨 **Custom LZB Branding** - Personalized interface with LZB logo and styling
- 🤖 **Multiple AI Providers** - Support for Ollama, OpenAI, and other LLM providers
- 📚 **RAG Support** - Upload documents and chat with your data
- 🔒 **Privacy First** - Self-hosted with complete data control
- 🌐 **Multi-Language** - Support for multiple languages
- 🎯 **Model Management** - Easy model switching and configuration
- 📱 **Responsive Design** - Works on desktop, tablet, and mobile
- 🔄 **Auto-Updates** - Automated upstream synchronization with custom preservation

## 🐳 Quick Start

### Simple Run
```bash
docker run -d \
  -p 3000:8080 \
  --name lzb-ai-platform \
  ngsankar/lzb-ai-platform:latest
```

### With Persistent Data
```bash
docker run -d \
  -p 3000:8080 \
  -v lzb_data:/app/backend/data \
  -e WEBUI_NAME="LZB AI Platform" \
  --name lzb-ai-platform \
  ngsankar/lzb-ai-platform:latest
```

### Full Docker Compose Setup
```yaml
version: '3.8'
services:
  lzb-ai-platform:
    image: ngsankar/lzb-ai-platform:latest
    container_name: lzb-ai-platform
    ports:
      - "3000:8080"
    environment:
      - WEBUI_NAME=LZB AI Platform
      - WEBUI_SECRET_KEY=your-secret-key
    volumes:
      - lzb_data:/app/backend/data
    restart: unless-stopped

volumes:
  lzb_data:
```

## 🔧 Configuration

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `WEBUI_NAME` | `LZB AI Platform` | Application title |
| `WEBUI_SECRET_KEY` | Auto-generated | Secret key for sessions |
| `WEBUI_URL` | `http://localhost:3000` | Base URL for the application |
| `OLLAMA_BASE_URL` | Not set | Ollama server URL |
| `OPENAI_API_KEY` | Not set | OpenAI API key |
| `DATABASE_URL` | SQLite | Database connection string |
| `ENABLE_SIGNUP` | `true` | Allow new user registration |

### Volumes

- `/app/backend/data` - Application data and database
- `/app/models` - Custom model storage (optional)
- `/app/documents` - Document uploads for RAG (optional)

## 🌟 What's Different from Open WebUI

- ✅ **Custom LZB Branding** - Logo, favicon, and splash screens
- ✅ **Automated Updates** - GitHub Actions workflow for upstream sync
- ✅ **Enhanced Documentation** - Comprehensive setup and usage guides
- ✅ **Production Ready** - Optimized configuration and security settings

## 🔗 Integration Examples

### With Ollama
```bash
# Start Ollama
docker run -d -p 11434:11434 --name ollama ollama/ollama

# Start LZB AI Platform with Ollama
docker run -d \
  -p 3000:8080 \
  -e OLLAMA_BASE_URL=http://ollama:11434 \
  --link ollama \
  ngsankar/lzb-ai-platform:latest
```

### With OpenAI
```bash
docker run -d \
  -p 3000:8080 \
  -e OPENAI_API_KEY=your-api-key \
  ngsankar/lzb-ai-platform:latest
```

## 📊 Available Tags

- `latest` - Latest stable release
- `v0.6.15` - Specific version tags
- `main-<sha>` - Development builds from main branch

## 🛠️ Building Locally

```bash
git clone https://github.com/ngsankar-lab/open-webui.git
cd open-webui
docker build -t lzb-ai-platform .
```

## 🔒 Security Notes

- Change default `WEBUI_SECRET_KEY` in production
- Use HTTPS in production environments
- Regularly update to latest version for security patches
- Review environment variables for sensitive data

## 📚 Documentation

- [GitHub Repository](https://github.com/ngsankar-lab/open-webui)
- [Original Open WebUI Docs](https://docs.openwebui.com/)
- [Docker Hub Repository](https://hub.docker.com/r/ngsankar/lzb-ai-platform)

## 🆘 Support

- 🐛 **Issues**: [GitHub Issues](https://github.com/ngsankar-lab/open-webui/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/ngsankar-lab/open-webui/discussions)
- 📧 **Contact**: Create an issue for support

## 📝 License

This project is based on [Open WebUI](https://github.com/open-webui/open-webui) and maintains the same MIT license.

---

🤖 **Built with ❤️ for LZB AI Platform**  
⭐ **Star us on GitHub** if you find this useful!