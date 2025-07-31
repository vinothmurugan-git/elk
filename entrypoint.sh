#!/bin/bash

# Start Elasticsearch in the background
echo "Starting Elasticsearch..."
/usr/local/bin/docker-entrypoint.sh &

# Wait for Elasticsearch to be ready
echo "Waiting for Elasticsearch to be fully up..."
until nc -z localhost 9200; do
  echo "Elasticsearch not ready yet, waiting..."
  sleep 5
done

# Create kibana_user if it doesn’t exist
echo "Creating kibana_user..."
/usr/share/elasticsearch/bin/elasticsearch-users useradd elastic -p kibana_passwd -r elasticpasswd || echo "kibana_user already exists or creation failed."

echo "User setup complete."
