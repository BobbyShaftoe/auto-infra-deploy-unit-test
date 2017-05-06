#!/usr/bin/env bash

#  export a_zookeeper="172.19.0.3:2181"
#  Docker ip address of zookeeper container


################################     KAFKA QUICKSTART    ##########################################
#  https://kafka.apache.org/quickstart

#    https://github.com/yaravind/kafka-connect-jenkins
#    http://wurstmeister.github.io/kafka-docker/
#    https://github.com/wurstmeister/kafka-docker

#    http://stackoverflow.com/questions/33273587/how-to-write-a-file-to-kafka-producer

#    https://cwiki.apache.org/confluence/display/KAFKA/Ecosystem


#  Get IP ADDRESS of container
  docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "${CONTAINER_ID}"

#  @@@@@@@@@@@@@@@@@@@@  Kafka Shell @@@@@@@@@@@@@@@@@@@@
#  NOTE:
#  You can interact with your Kafka cluster via the Kafka shell:

#  start-kafka-shell.sh <DOCKER_HOST_IP> <ZK_HOST:ZK_PORT>

   start-kafka-shell.sh  ${DOCKER_HOST_IP} ${ZK_HOST}:2181

  DOCKER_HOST_IP=`ip -o -4 addr show docker0 | awk -F '[ /]+' '/global/ {print $4}'`
  ZK_HOST=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "${CONTAINER_ID}"`


#  How to write a file to Kafka Producer
# you can pipe it in
  kafka-console-produce.sh --broker-list localhost:9092 --topic my_topic --new-producer < my_file.txt
  kafka-console-producer.sh --broker-list localhost:9092 --topic my_topic < my_file.txt


#    Testing
#    To test your setup, start a shell, create a topic and start a producer:
#
 $KAFKA_HOME/bin/kafka-topics.sh --create --topic topic \
 --partitions 4 --zookeeper $ZK --replication-factor 2

 $KAFKA_HOME/bin/kafka-topics.sh --describe --topic topic --zookeeper $ZK
 $KAFKA_HOME/bin/kafka-console-producer.sh --topic=topic \
 --broker-list=`broker-list.sh`

#    Start another shell and start a consumer:

 $KAFKA_HOME/bin/kafka-console-consumer.sh --topic=topic --zookeeper=$ZK




You can pipe it in:

kafka-console-produce.sh --broker-list localhost:9092 --topic my_topic
--new-producer < my_file.txt

kafka-console-producer.sh --broker-list localhost:9092 --topic my_topic < my_file.tx