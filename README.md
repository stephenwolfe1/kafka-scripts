# Useful Kafka Commands and scripts
These commands are designed to be run inside a docker container, print results to the console, and delete the container upon completion. Alternatively, kubernetes.yaml is a pod definition that can be deployed to a kubernetes cluster, and then users can exec into the pod and run the commands locally. This can be useful with kafka cluster is not directly accessible from the user's local environment.
## File descriptions
- **topic_commands.sh**
Commands to create and manage topics
- **consumer_commands.sh**
Commands to create and manage topics
- **reassign_commands.sh**
Commands to generate and execute a partition reassignment
- **loops.sh**
Simple bash loop that can be modified with any kafka management command
## Other considerations
- The kubernetes pod can be deployed with environment variables for the default kafka and zookeeper clusters, and then changed as needed once exec'd into the pod.
- Docker environment required to run the commands or use the kafka client pattern
- Zookeeper and Kafka commands can very based on the cluster version, adjusting the docker tag for cp-kafka to an older version that matches the cluster they are been executed against can be helpful.
