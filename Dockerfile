FROM ghost:latest

# Copy your custom start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Override default CMD
CMD ["/start.sh"]