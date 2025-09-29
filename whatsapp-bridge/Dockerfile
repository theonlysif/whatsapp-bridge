# Use Go 1.23 alpine image for better compatibility
FROM golang:1.23-alpine AS builder

# Install required packages for CGO (needed for SQLite)
RUN apk add --no-cache gcc musl-dev sqlite-dev

# Set working directory
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the application with CGO enabled for SQLite
RUN CGO_ENABLED=1 GOOS=linux go build -a -installsuffix cgo -o main .

# Start a new stage from alpine for runtime
FROM alpine:latest

# Install ca-certificates for HTTPS requests and sqlite3 for database
RUN apk --no-cache add ca-certificates sqlite

WORKDIR /root/

# Copy the pre-built binary file from the previous stage
COPY --from=builder /app/main .

# Create store directory for database and media files
RUN mkdir -p store

# Expose the port the app runs on
EXPOSE 8080

# Set environment variables with defaults
ENV PORT=8080
ENV GIN_MODE=release

# Command to run the executable
CMD ["./main"]