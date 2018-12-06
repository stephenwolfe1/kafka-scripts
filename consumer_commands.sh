export ZOOKEEPER='localhost:2181'
export BOOTSTRAP='localhost:9092'
export GROUP='ConsumerGroupName'


#List Zookeeper based consumer groups
docker run \
  --net=host \
  --rm confluentinc/cp-kafka:latest \
  kafka-consumer-groups --zookeeper $ZOOKEEPER --list

#List Kafka based consumer groups
docker run \
  --net=host \
  --rm confluentinc/cp-kafka:latest \
  kafka-consumer-groups --bootstrap-server $BOOTSTRAP --list

#List the members of a Kafka based consumer group
docker run \
  --net=host \
  --rm confluentinc/cp-kafka:latest \
  kafka-consumer-groups --bootstrap-server $BOOTSTRAP --describe --group $GROUP --members --timeout 10000

#List the status of a Kafka based consumer group
docker run \
  --net=host \
  --rm confluentinc/cp-kafka:latest \
  kafka-consumer-groups --bootstrap-server $BOOTSTRAP --describe --group $GROUP --timeout 10000
