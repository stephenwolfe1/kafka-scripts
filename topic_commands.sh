export ZOOKEEPER='localhost:2181'
export BOOTSTRAP='localhost:9092'
export TOPIC='YourTopicName'


#Verify broker api
docker run \
  --net=host \
  --rm confluentinc/cp-kafka:latest \
  kafka-broker-api-versions --bootstrap-server $BOOTSTRAP

#Get a list of Topics
docker run \
  --net=host \
  --rm confluentinc/cp-kafka:latest \
  kafka-topics --zookeeper $ZOOKEEPER --list

#Describe a Topic
docker run \
  --net=host \
  --rm confluentinc/cp-kafka:latest \
  kafka-topics --zookeeper $ZOOKEEPER --describe --topic $TOPIC

#Create a topic is it doesnt's exist --Set approriate partitions and replication-factor
docker run \
  --net=host \
  --rm confluentinc/cp-kafka:latest \
  kafka-topics --zookeeper $ZOOKEEPER --create --topic $TOPIC --if-not-exists --partitions 8 --replication-factor 2

#Alter an existing topic to increase partitiona
docker run \
  --net=host \
  --rm confluentinc/cp-kafka:latest \
  kafka-topics --zookeeper $ZOOKEEPER --alter --partitions 16 --topic $TOPIC

#Produce data to a topic
docker run \
  --net=host \
  --rm confluentinc/cp-kafka:latest \
  bash -c "seq 1000 | kafka-console-producer --request-required-acks 1 --broker-list $BOOTSTAP --topic $TOPIC && echo 'Produced 1000 messages.'"

#Consume messages from a topic to console
docker run \
  --net=host \
  --rm confluentinc/cp-kafka:latest \
  kafka-console-consumer --bootstrap-server $BOOTSTAP --topic $TOPIC --from-beginning --max-messages 500

#Delete a topic
docker run \
  --net=host \
  --rm confluentinc/cp-kafka:latest \
  kafka-topics --zookeeper $ZOOKEEPER --delete --topic $TOPIC
