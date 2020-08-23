# Kafka

- [Kafka Basics](#kafka-basics)
- [Java Basics](#java-basics)
  - [work with json](#work-with-json)
- [Kafka Streams](#kafka-streams)
- [KSQL](#ksql)
- [Monitoring](#monitoring)

The notes covers various message systems, including kafak, pubsub, and also review some basic java knowledge.

## Reading
get some idea of volumn of data: spotify 700K events per second, future 2M /sec

[spotify migrate to pubsub](https://labs.spotify.com/2016/03/10/spotifys-event-delivery-the-road-to-the-cloud-part-iii/)

## Kafka Basics

To have launchd start kafka now and restart at login:
`brew services start kafka`

Or, if you don't want/need a background service you can just run:
```bash
zookeeper-server-start /usr/local/etc/kafka/zookeeper.properties
kafka-server-start /usr/local/etc/kafka/server.properties
```
 
where does homebrew store kafka configurations: `/usr/local/etc/kafka`

zookeeper default port `2181`

kafka broker default port `9092`

change `advertisted.listen` in server.properties to access remote machine

## Useful commands

```bash
kafka-topics --create --zookeeper 127.0.0.1:2181 --replication-factor 1 --partitions 1 --topic <topic_name>
kafka-topics --list --bootstrap-server PLAINTEXT://127.0.0.1:9092
```

## Java basics

```bash
mvn clean package
java -jar <path_to_jar>
```

### Work with json

[Jackson databind](http://tutorials.jenkov.com/java-json/jackson-objectmapper.html)

## Best practice

create topics before produce data to them.

consumer flags -- group -- from-begining

## Kafka streams

**Notes**: kafak stream v.2.4 introduced quite a few changes, I've experienced that when I dealt with 2.0.0. The changes include new test api, in which you can define `inputTestTopic` and `outputTestTopic`. Check out the blog [here](https://www.confluent.io/blog/test-kafka-streams-with-topologytestdriver/?_ga=2.171256416.1586641422.1594704641-736325823.1594094562).

```java
// after 2.4.0
inputTopic = testDriver.createInputTopic(WordCountDemo.INPUT_TOPIC, new StringSerializer(), new StringSerializer());
outputTopic = testDriver.createOutputTopic(WordCountDemo.OUTPUT_TOPIC, new StringDeserializer(), new LongDeserializer());
```

- [kafka-streams-course-code-repo](https://github.com/simplesteph/kafka-streams-course/tree/2.0.0)
- [kafka-tutorials-repo](https://github.com/confluentinc/kafka-tutorials)
- [find-max-min-in-stream-events](https://kafka-tutorials.confluent.io/create-stateful-aggregation-minmax/kstreams.html#consume-aggregated-results-from-the-output-topic)
- [zorteran-kafka-streams](https://github.com/zorteran/wiadro-danych-kafka-streams)
- [companion medium post](https://medium.com/@zorteran/calculating-speed-bearing-and-distance-using-kafka-streams-processor-api-9e95834b9e3d)
- [simon albury - smart meters](https://github.com/southpolemonkey/stream-smarts)

`application.id` important config for stream application, used as `Consumer.group.id = application.id`

some concepts:

- topology
- streams
- internal topics
- Kstream vs KTable
- **(advanced)** Log compacted topic
- MapValues vs Map
- Filter vs FilterNot
- FlatMapValues vs FlatMap (for kstream only)
- Map, FlatMap, SelectKey will trigger **re-partition**
- branch (work like case statement)
- selectKey (assigns a new key)
- read from kafka `build.stream(topic_name)`
- write to kafka `build.to(topic_name)` or `build.through(topic_name)`
- transform between kstream and ktable

more operations:

- ktable: count, reduce, aggregate
- kstream: peek, Transform, TransformValues
- KStream ----> KGroupedStream

What is *Exactly-One semantics*?

Join:
- GlobalKTable, a reasonbly smaller table, think of it works as a reference table
 


[Is key requireed for kafka message?](https://stackoverflow.com/questions/29511521/is-key-required-as-part-of-sending-messages-to-kafka/61912094#61912094)

## Annex

### kafka producer config options

```text
[main] INFO org.apache.kafka.clients.producer.ProducerConfig - ProducerConfig values: 
	acks = all
	batch.size = 32768
	bootstrap.servers = [127.0.0.1:9092]     # broker address
	key.serializer = class org.apache.kafka.common.serialization.StringSerializer
    value.serializer = class org.apache.kafka.common.serialization.StringSerializer
	partitioner.class = class org.apache.kafka.clients.producer.internals.DefaultPartitioner
	buffer.memory = 33554432
	client.id = 
	compression.type = snappy
	connections.max.idle.ms = 540000
	enable.idempotence = true
	interceptor.classes = []
	linger.ms = 20
	max.block.ms = 60000
	max.in.flight.requests.per.connection = 5
	max.request.size = 1048576
	metadata.max.age.ms = 300000
	metrics.num.samples = 2
	metrics.recording.level = INFO
	metrics.sample.window.ms = 30000
    ...
```

## KSQL 


## Monitoring