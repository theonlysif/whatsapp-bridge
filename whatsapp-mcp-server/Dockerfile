FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY pyproject.toml .

# Install Python dependencies
RUN pip install -e .

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Set environment variables
ENV MCP_HOST=0.0.0.0
ENV MCP_PORT=3000

# Run the server
CMD ["python", "main.py"]