#!/bin/bash

/etc/confluent/docker/run &

echo "Waiting for Kafka to be ready..."
cub kafka-ready -b localhost:9092 1 20

create_topic_if_not_exists () {
  local topic=$1
  local partitions=$2
  local replication=$3

  if
    kafka-topics --bootstrap-server localhost:9092 --list | grep -q "^${topic}$";
  then
    echo "Topic '${topic}' already exists."
  else
    kafka-topics --create \
      --topic "${topic}" \
      --bootstrap-server localhost:9092 \
      --replication-factor "${replication}" \
      --partitions "${partitions}"
    echo "Topic '${topic}' has been created."
  fi
}

create_topic_if_not_exists "order.events" 3 1
create_topic_if_not_exists "payment.events" 3 1
create_topic_if_not_exists "enrollment.events" 3 1

wait