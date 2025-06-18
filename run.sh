echo "Starting Ghost with MySQL configuration..."
# Load environment variables
source .env
echo "Environment variables:"
printenv | sort

docker run -d \
  -p 2368:2368 \
  -e database__client=mysql \
  -e database__connection__host=${MYSQL_HOST} \
  -e database__connection__port=${MYSQL_PORT} \
  -e database__connection__user=${MYSQL_USER} \
  -e database__connection__password=${MYSQL_PASSWORD} \
  -e database__connection__database=${MYSQL_DATABASE} \
  ghost:5-alpine