export ZOOKEEPER='localhost:2181'
export BOOTSTRAP='localhost:9092'
export TOPIC='YourTopicName'
export GROUP='ConsumerGroupName'


#Adjust the main command as needed
#Example will get a list of all topics, loop through, apply a topic name filter, and then descibe each topic
topics=$(docker run \
  --net=host \
  --rm confluentinc/cp-kafka:latest \
  kafka-topics --zookeeper $ZOOKEEPER --list)

for topic in $topics
do
  if [[ ! $topic =~ ^(__consumer_offsets|console.*)$ ]]
  then
    docker run \
      --net=host \
      --rm confluentinc/cp-kafka:latest \
      kafka-topics --zookeeper $ZOOKEEPER --describe $topic
  fi
done


#Or to run inside a kafka client container or pod
topics=$(kafka-topics --zookeeper $ZOOKEEPER --list)
for topic in $topics
do
  kafka-topics --zookeeper $ZOOKEEPER --describe $topic
done
