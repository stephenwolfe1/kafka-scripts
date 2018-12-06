export ZOOKEEPER='localhost:2181'
export BOOTSTRAP='localhost:9092'
export TOPIC='YourTopicName'


#Produce a reassignment json file and output to host filesystem
#Skip file to generate reassignment for all topics
cat << EOF > /tmp/topics-to-move.json
{
 "partitions":
  [
    {"topic": "topic1", "partition": 0},
    {"topic": "topic1", "partition": 1},
    {"topic": "topic1", "partition": 2},
    {"topic": "topic2", "partition": 0},
    {"topic": "topic2", "partition": 1}
  ]
}
EOF

docker run \
  --net=host \
  -v /tmp/topics-to-move.json:/tmp/topics-to-move.json \
  --rm confluentinc/cp-kafka:latest \
  kafka-reassign-partitions --zookeeper $ZOOKEEPER --topics-to-move-json-file /tmp/topics-to-move.json --broker-list "0,1,3" --generate

#Execute the reassignment file that was produced
docker run \
  --net=host \
  -v /tmp/expand-cluster-reassignment.json:/tmp/expand-cluster-reassignment.json \
  --rm confluentinc/cp-kafka:latest \
  kafka-reassign-partitions --zookeeper $ZOOKEEPER --reassignment-json-file /tmp/expand-cluster-reassignment.json --execute

#Check the status of the running reassignment
docker run \
  --net=host \
  -v /tmp/expand-cluster-reassignment.json:/tmp/expand-cluster-reassignment.json \
  --rm confluentinc/cp-kafka:latest \
  kafka-reassign-partitions --zookeeper $ZOOKEEPER --reassignment-json-file /tmp/expand-cluster-reassignment.json --verify #| grep "still in progress"
