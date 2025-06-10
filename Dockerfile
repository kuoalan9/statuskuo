FROM ghost:latest

COPY source/ /var/lib/ghost/content/themes/source/

# Copy your custom start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Override default CMD
CMD ["/start.sh"]