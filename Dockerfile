FROM ghost:latest

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy your custom start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Override default CMD
CMD ["/start.sh"]