# kafka


get some idea of volumn of data
spotify 700K events per second, future 2M /sec

## Reading

[spotify migrate to pubsub](https://labs.spotify.com/2016/03/10/spotifys-event-delivery-the-road-to-the-cloud-part-iii/)

kafka installation

> To have launchd start kafka now and restart at login:
  brew services start kafka
Or, if you don't want/need a background service you can just run:
  zookeeper-server-start /usr/local/etc/kafka/zookeeper.properties & kafka-server-start /usr/local/etc/kafka/server.properties


where does homebrew store kafka configurations: `/usr/local/etc/kafka`

zookeeper default port `2181`

kafka default port

broker default port `9092`

## Best practice

create topics before produce data to them.

consumer flags

-- group

-- from-beginin

maven - kafka-client
