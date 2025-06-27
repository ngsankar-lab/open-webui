# 🐳 Docker Setup Guide for LZB AI Platform

This guide walks you through setting up Docker Hub integration and building your custom LZB AI Platform image.

## 📋 Prerequisites

- Docker Desktop installed and running
- Docker Hub account
- GitHub repository with secrets configured

## 🔧 Step 1: Docker Hub Setup

### Create Docker Hub Repository

1. Go to [Docker Hub](https://hub.docker.com)
2. Click **"Create Repository"**
3. Repository name: `lzb-ai-platform`
4. Visibility: Public (or Private if preferred)
5. Click **"Create"**

### Generate Access Token

1. Go to [Docker Hub Account Settings](https://hub.docker.com/settings/security)
2. Click **"New Access Token"**
3. Description: `LZB AI Platform GitHub Actions`
4. Permissions: **Read, Write, Delete**
5. Click **"Generate"**
6. **Copy the token** (you won't see it again!)

## 🔑 Step 2: GitHub Secrets Configuration

Add these secrets to your GitHub repository:

1. Go to your repository on GitHub
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **"New repository secret"** for each:

| Secret Name | Value | Description |
|-------------|-------|-------------|
| `DOCKER_HUB_USERNAME` | `your-username` | Your Docker Hub username |
| `DOCKER_HUB_TOKEN` | `your-token` | Token from Step 1 |

## 🚀 Step 3: Build and Push Options

### Option A: Manual Build (Local)

```bash
# 1. Make sure Docker is running
docker --version

# 2. Log in to Docker Hub
docker login

# 3. Run the build script
./build-docker.sh
```

### Option B: Automated Build (GitHub Actions)

The GitHub Actions workflow will automatically:
- Build on every push to main branch
- Build on new tags (releases)
- Push to Docker Hub automatically

To trigger a build:
```bash
# Push to main branch
git push origin main

# Or create a release tag
git tag v1.0.0
git push origin v1.0.0
```

### Option C: Manual Docker Commands

```bash
# Build the image
docker build -t ngsankar/lzb-ai-platform:latest .

# Tag for Docker Hub
docker tag ngsankar/lzb-ai-platform:latest ngsankar/lzb-ai-platform:v0.6.15

# Push to Docker Hub
docker push ngsankar/lzb-ai-platform:latest
docker push ngsankar/lzb-ai-platform:v0.6.15
```

## 🏃‍♂️ Step 4: Test Your Image

### Local Testing
```bash
# Run your custom image
docker run -d -p 3000:8080 --name lzb-test ngsankar/lzb-ai-platform:latest

# Check logs
docker logs lzb-test

# Open browser
open http://localhost:3000
```

### Docker Compose Testing
```bash
# Use the provided compose file
docker-compose -f docker-compose.lzb.yml up -d

# Check status
docker-compose -f docker-compose.lzb.yml ps

# View logs
docker-compose -f docker-compose.lzb.yml logs -f
```

## 🔄 Step 5: Update Workflow

### Update Docker Hub Username

1. Edit `.github/workflows/docker-build-and-push.yml`
2. Change line 13:
   ```yaml
   IMAGE_NAME: your-username/lzb-ai-platform
   ```

3. Edit `build-docker.sh`
4. Change line 8:
   ```bash
   DOCKER_HUB_USERNAME="${DOCKER_HUB_USERNAME:-your-username}"
   ```

3. Edit `DOCKER_README.md` and update all references to your username

## 📊 Step 6: Monitor Builds

### GitHub Actions
- Go to **Actions** tab in your repository
- Monitor the **"Build and Push Docker Image"** workflow
- Check build logs and status

### Docker Hub
- Visit your repository: `https://hub.docker.com/r/your-username/lzb-ai-platform`
- Check for new tags and build status
- Verify image sizes and scan results

## 🛠️ Troubleshooting

### Build Fails
```bash
# Check Docker daemon
docker info

# Check available space
docker system df

# Clean up if needed
docker system prune -a
```

### Push Fails
```bash
# Re-login to Docker Hub
docker logout
docker login

# Check token permissions
# Regenerate token if needed
```

### GitHub Actions Fails
- Check secrets are correctly set
- Verify Docker Hub token has correct permissions
- Check workflow syntax with GitHub Actions tab

## 🏷️ Image Tags Strategy

Your images will be tagged as:
- `latest` - Latest main branch build
- `v0.6.15` - Specific version from package.json
- `main-abc123` - Git commit SHA builds

## 🔒 Security Best Practices

1. **Use specific tags** in production, not `latest`
2. **Regularly update** base images
3. **Scan images** for vulnerabilities
4. **Rotate tokens** periodically
5. **Use minimal permissions** for tokens

## 📱 Usage Examples

### Production Deployment
```bash
docker run -d \
  -p 80:8080 \
  -e WEBUI_SECRET_KEY="$(openssl rand -base64 32)" \
  -e WEBUI_URL="https://yourdomain.com" \
  -v lzb_data:/app/backend/data \
  --restart unless-stopped \
  --name lzb-ai-platform \
  ngsankar/lzb-ai-platform:v0.6.15
```

### Development
```bash
docker run -d \
  -p 3000:8080 \
  -e WEBUI_NAME="LZB AI Platform (Dev)" \
  -v $(pwd)/data:/app/backend/data \
  --name lzb-dev \
  ngsankar/lzb-ai-platform:latest
```

---

🎉 **You're all set!** Your LZB AI Platform is now ready for Docker deployment!