# Use the official Ghost image
FROM ghost:5-alpine

# Set the working directory
WORKDIR /var/lib/ghost

# Copy any custom configuration if needed
# COPY config.production.json ./

# Expose the port Ghost runs on
EXPOSE 2368

# Ghost will automatically use environment variables for database configuration
# No need to set them here - Render will inject them