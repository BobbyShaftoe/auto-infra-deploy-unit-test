#!/usr/bin/env bash

#  export a_zookeeper="172.19.0.3:2181"
#  Docker ip address of zookeeper container

You can pipe it in:

kafka-console-produce.sh --broker-list localhost:9092 --topic my_topic
--new-producer < my_file.txt

kafka-console-producer.sh --broker-list localhost:9092 --topic my_topic < my_file.tx