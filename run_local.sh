docker build -t local-ghost .
docker run -d -p 2368:2368 --env-file .env --name status_kuo local-ghost