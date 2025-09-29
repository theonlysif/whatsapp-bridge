# WhatsApp Bridge Deployment Guide

This guide covers deploying the WhatsApp Bridge to cloud hosting platforms.

## 🚀 Quick Start

The WhatsApp Bridge can be deployed to several platforms. Both **Render.com** and **Railway** are recommended for their simplicity and free tiers.

## 📦 Prerequisites

1. Your code should be in a Git repository (GitHub, GitLab, etc.)
2. Ensure all configuration files are committed:
   - `Dockerfile`
   - `render.yaml` (for Render)
   - `railway.toml` (for Railway)

## 🔧 Platform-Specific Deployment

### Option 1: Render.com (Recommended)

Render.com offers automatic scaling and easy deployment with their free tier.

#### Steps:
1. **Sign up** at [render.com](https://render.com)
2. **Connect your repository**:
   - Click "New +" → "Web Service"
   - Connect your GitHub/GitLab repository
   - Select your repository and branch (usually `main`)
3. **Configure deployment**:
   - Render will automatically detect the `render.yaml` file
   - Or manually configure:
     - **Environment**: Docker
     - **Build Command**: (leave empty, Docker handles this)
     - **Start Command**: (leave empty, Docker handles this)
     - **Port**: 8080
4. **Deploy**: Click "Create Web Service"

#### Environment Variables (if not using render.yaml):
- `PORT`: 8080
- `GIN_MODE`: release

### Option 2: Railway (Alternative)

Railway provides a simple deployment experience with automatic builds.

#### Steps:
1. **Sign up** at [railway.app](https://railway.app)
2. **Deploy from GitHub**:
   - Click "Start a New Project"
   - Select "Deploy from GitHub repo"
   - Choose your repository
3. **Configure**:
   - Railway will automatically detect the `railway.toml` file
   - It will use the Dockerfile for building
4. **Deploy**: Railway will automatically build and deploy

### Option 3: Other Platforms

The application can also be deployed to:
- **Heroku**: Use the Dockerfile with Heroku's container runtime
- **Google Cloud Run**: Deploy the Docker image to Cloud Run
- **AWS App Runner**: Deploy using the Dockerfile
- **DigitalOcean App Platform**: Use the Docker configuration

## 🔌 API Endpoints

Once deployed, your WhatsApp Bridge will expose these endpoints:

### Send Message
```bash
POST https://your-app-url.com/api/send
Content-Type: application/json

{
  "recipient": "1234567890",  // Phone number or JID
  "message": "Hello World",
  "media_path": "/path/to/media" // Optional
}
```

### Download Media
```bash
POST https://your-app-url.com/api/download
Content-Type: application/json

{
  "message_id": "message_id_here",
  "chat_jid": "chat_jid_here"
}
```

## ⚠️ Important Considerations

### 1. Database Persistence
- **SQLite files** are stored in the `store/` directory
- On most cloud platforms, **files are ephemeral** (lost on restart)
- Consider using a **persistent volume** or **external database** for production

### 2. WhatsApp Authentication
- The app requires **QR code scanning** for first-time setup
- You'll need to scan the QR code after deployment
- Authentication session is stored in the SQLite database

### 3. Media Storage
- Downloaded media is stored locally in `store/chat_jid/`
- This is also ephemeral on most platforms
- Consider using **cloud storage** (AWS S3, Google Cloud Storage) for media

### 4. Scaling Limitations
- WhatsApp Web connections are **single-session**
- Multiple instances won't work with the same WhatsApp account
- Use **single instance scaling** only

## 🛠️ Troubleshooting

### Common Issues:

1. **Build Failures**
   - Ensure `go.mod` and `go.sum` are committed
   - Check that all dependencies are available
   - Verify Go version compatibility (1.24+)

2. **Runtime Errors**
   - Check logs for SQLite database creation issues
   - Verify port binding (should use `PORT` environment variable)
   - Ensure proper file permissions for `store/` directory

3. **WhatsApp Connection Issues**
   - Generate new QR code if authentication fails
   - Check network connectivity from the hosting platform
   - Verify WebSocket connections are allowed

### Logs and Debugging:

Most platforms provide log access:
- **Render**: View logs in the dashboard
- **Railway**: Check the deployment logs
- **Heroku**: Use `heroku logs --tail`

## 🔒 Security Notes

- The bridge exposes API endpoints publicly
- Consider adding **API authentication** for production use
- Store sensitive configuration in **environment variables**
- Use **HTTPS** (automatically provided by most platforms)

## 🎯 Next Steps After Deployment

1. **Test the deployment** by sending a test message
2. **Scan QR code** to authenticate with WhatsApp
3. **Set up monitoring** to track uptime and performance
4. **Configure alerts** for service interruptions
5. **Consider adding authentication** to secure your API endpoints

## 💡 Tips for Production

- Use a **custom domain** for your API
- Set up **health checks** and **monitoring**
- Consider **rate limiting** to prevent abuse
- Implement **proper error handling** and **logging**
- Back up your **session data** regularly

---

Need help? Check the platform-specific documentation or raise an issue in the repository.