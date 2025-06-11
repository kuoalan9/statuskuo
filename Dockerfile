FROM ghost:latest

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Create all necessary content directories
RUN mkdir -p /var/lib/ghost/content/themes
RUN mkdir -p /var/lib/ghost/content/data
RUN mkdir -p /var/lib/ghost/content/logs
RUN mkdir -p /var/lib/ghost/content/adapters
RUN mkdir -p /var/lib/ghost/content/images

# Copy default themes from Ghost installation to content directory
RUN cp -r /var/lib/ghost/current/content/themes/* /var/lib/ghost/content/themes/

# Set proper ownership for all content
RUN chown -R node:node /var/lib/ghost/content

# Copy your custom start script
COPY ping.sh /ping.sh
RUN chmod +x /ping.sh

# Override default CMD
CMD ["/ping.sh"]