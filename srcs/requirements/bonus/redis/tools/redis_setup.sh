#!/bin/bash

## Comment out the line in the Redis configuration file that specifies binding to localhost,
# effectively allowing Redis to listen on all available network interfaces.
#
# Redis is configured to listen only on the loopback interface (localhost) for security reasons,
# meaning it can only be accessed from the same machine where Redis is installed.
sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis/redis.conf

## Update the maximum memory setting in the Redis configuration file to 2 megabytes
#
# Without a memory limit, Redis could potentially use all available system memory,
# which could lead to performance problems or system instability.
#
# By setting a maximum memory limit (maxmemory), Redis will actively manage memory usage,
# evicting less-used data when it reaches the specified limit.
sed -i "s|# maxmemory <bytes>|maxmemory 2mb|g" /etc/redis/redis.conf

## Update the memory eviction policy in the Redis configuration file to use the "allkeys-lru" policy.
#
# Redis provides several memory eviction policies to decide which keys to remove when the
# maximum memory limit is reached.
#
# The default policy is noeviction, which means Redis will not remove any data and will return
# errors if memory is exhausted.
#
# By changing the policy to allkeys-lru, Redis will automatically remove the least recently
# used keys to free up memory when it reaches the specified limit
sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis/redis.conf

## Setting protected mode to false
#
# Protected mode is a security feature in Redis that is enabled by default,
# designed to prevent unauthorized access to the Redis server.
#
# When protected mode is enabled (the default), Redis only allows connections from the
# localhost (127.0.0.1) by default, meaning that Redis can only be accessed from the same
# machine where it's running.
exec redis-server --protected-mode no