# WhatsApp Web API Bridge

A REST API bridge for WhatsApp Web that allows you to send and receive messages programmatically.

## Features

- 📱 **Send Messages**: Send text messages and media files via REST API
- 📥 **Receive Messages**: Automatically store incoming messages in SQLite database
- 🖼️ **Media Support**: Send and download images, videos, audio, and documents
- 🔄 **Message History**: Sync and store message history from WhatsApp
- 🔌 **REST API**: Simple HTTP endpoints for integration
- 🐳 **Docker Ready**: Containerized for easy deployment

## Quick Start

### Local Development

1. **Clone the repository**:
   ```bash
   git clone https://github.com/theonlysif/whatsapp-bridge.git
   cd whatsapp-bridge
   ```

2. **Install dependencies**:
   ```bash
   go mod download
   ```

3. **Run the application**:
   ```bash
   go run main.go
   ```

4. **Scan QR Code**: Open the application and scan the QR code with your WhatsApp app

5. **Test the API**:
   ```bash
   curl -X POST http://localhost:8080/api/send \
     -H "Content-Type: application/json" \
     -d '{"recipient": "1234567890", "message": "Hello from WhatsApp Bridge!"}'
   ```

## 🚀 Deployment

Ready to deploy to the cloud? Check out the comprehensive [DEPLOYMENT.md](./DEPLOYMENT.md) guide.

**Supported Platforms:**
- ✅ **Render.com** (Recommended)
- ✅ **Railway** 
- ✅ **Heroku**
- ✅ **Google Cloud Run**
- ✅ **AWS App Runner**

## API Endpoints

### Send Message
```http
POST /api/send
Content-Type: application/json

{
  "recipient": "1234567890",
  "message": "Hello World!",
  "media_path": "/path/to/file.jpg"
}
```

### Download Media
```http
POST /api/download
Content-Type: application/json

{
  "message_id": "message_id_here",
  "chat_jid": "chat_jid_here"
}
```

## Architecture

- **Go 1.24+** - Core application
- **whatsmeow** - WhatsApp Web client library
- **SQLite** - Local message and session storage
- **REST API** - HTTP endpoints for integration
- **Docker** - Containerization support

## Important Notes

⚠️ **Single Session**: WhatsApp Web only supports one active session per account
⚠️ **Authentication**: Requires QR code scanning for initial setup
⚠️ **Rate Limits**: Respect WhatsApp's rate limiting policies

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is open source and available under the [MIT License](LICENSE).

## Support

- 📖 Read the [Deployment Guide](./DEPLOYMENT.md)
- 🐛 [Report Issues](https://github.com/theonlysif/whatsapp-bridge/issues)
- 💬 [Discussions](https://github.com/theonlysif/whatsapp-bridge/discussions)

---

**⭐ Star this repository if you find it helpful!**