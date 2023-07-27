FROM redis:latest

COPY ./start_redis.sh /usr/local/bin/

EXPOSE 6379
CMD ["start_redis.sh"]
