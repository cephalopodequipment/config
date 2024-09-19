<?xml version="1.0"?>
<clickhouse>
    <zookeeper>
        <node index="1">
            {{ range service "zookeeper-client" }}
                <host>{{ .Address }}</host>
                <port>{{ .Port }}</port>
            {{ end }}
        </node>
    </zookeeper>
    <remote_servers>
        <cluster>
            <shard>
                <replica>
                    <host>{{ env "HOSTNAME" }}</host>
                    <port>9000</port>
                </replica>
            </shard>
        </cluster>
    </remote_servers>
</clickhouse>
