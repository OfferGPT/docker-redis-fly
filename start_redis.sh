#!/bin/sh

# Get swap size
SWAP_SIZE=${SWAP_SIZE:-512M}

# If $SWAP is 1, set up swap space
if [ "$SWAP" = "1" ]; then
  echo "Setting up swap space..."
  fallocate -l ${SWAP_SIZE} /swapfile
  chmod 0600 /swapfile
  mkswap /swapfile
  echo 10 > /proc/sys/vm/swappiness
  swapon /swapfile
  echo 1 > /proc/sys/vm/overcommit_memory
fi

# Redis config
REDIS_CONF="/etc/redis/redis.conf"
# Read from REDIS_PORT, default 6379
REDIS_PORT=${REDIS_PORT:-6379}

# Write TLS cert to file
echo "$REDIS_TLS_CERT" > /etc/redis/redis.crt
# Write TLS key to file
echo "$REDIS_TLS_KEY" > /etc/redis/redis.key

# Write env vars to redis config file
echo "" > $REDIS_CONF
echo "bind * -::*" >> $REDIS_CONF
echo "requirepass $REDIS_PASSWORD" >> $REDIS_CONF
echo "timeout 0" >> $REDIS_CONF
echo "tcp-keepalive 300" >> $REDIS_CONF
echo "port 0" >> $REDIS_CONF
echo "tls-port $REDIS_PORT" >> $REDIS_CONF
echo "tls-cert-file /etc/redis/redis.crt" >> $REDIS_CONF
echo "tls-key-file /etc/redis/redis.key" >> $REDIS_CONF
echo "tls-auth-clients no" >> $REDIS_CONF
echo "tls-protocols \"TLSv1.2 TLSv1.3\"" >> $REDIS_CONF
echo "$EXTRA_REDIS_CONFIG" >> $REDIS_CONF

# Start redis server
redis-server $REDIS_CONF
