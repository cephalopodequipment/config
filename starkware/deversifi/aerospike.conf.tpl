# Aerospike database configuration file for use with systemd.

service {
        paxos-single-replica-limit 1 # Number of nodes where the replica count is automatically reduced to 1.
        proto-fd-max 60000
        cluster-name cephalopod
}

logging {
        console {
                context any info
        }
}

network {
        service {
                port 3000
        }

        heartbeat {
                mode mesh
                address any
                port 3002

                interval 150
                timeout 20
        }

        fabric {
                port 3001
        }

        info {
                port 3003
        }
}

namespace deversifi {
        replication-factor 1
        memory-size 24G

        # Eviction parameters: https://www.aerospike.com/docs/operations/configure/namespace/retention/
        default-ttl 0            # 30d = 30 days, How long (in seconds) to keep data after it is written
        high-water-disk-pct 90   # How full may the disk become before the server begins eviction
    	high-water-memory-pct 95 # How full may the memory become before the server begins eviction
	    stop-writes-pct 90       # How full may the memory become before we disallow new writes
	    nsup-period 0            # Maximum time between starting successive rounds of expiration or eviction - a value of zero disables expiration and eviction
        transaction-pending-limit 0 # The number of transactions that can wait on an object (multiple writes to same object) - Zero is unlimited

        storage-engine device {
                file /opt/aerospike/data/deversifi.dat
                filesize 300G
                data-in-memory false   # Store data in memory in addition to file.
                write-block-size 128K  # Default for HDD: 1M, recommended for SSD: 128K
                read-page-cache true   # enable read operation caching
        }
}
