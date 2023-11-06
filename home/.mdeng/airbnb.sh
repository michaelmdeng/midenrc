function tidb_mysql_cmd() {
	NS="tidb-$1" 
	CONTEXT="m-tidb-$2-ea1-us" 
	PASS=$(kubectl get secret -n "$NS" --context "$CONTEXT" tidb-secret -o json | jq .data.root -r | base64 -d | tr -d '\n')
	IP=$(kubectl get pod -n "$NS" --context "$CONTEXT" "$1-tidb-0" -o json | jq .status.podIP -r)
	echo "mysql -uroot -p$PASS -P 4000 -A -h $IP" | tee >(tr -d '\n' | pbcopy)
}

function tidb_mysql_local_cmd() {
	NS="tidb-$1" 
	CONTEXT="m-tidb-$2-ea1-us" 
	PASS=$(kubectl get secret -n "$NS" --context "$CONTEXT" tidb-secret -o json | jq .data.root -r | base64 -d | tr -d '\n')
	IP=$(kubectl get pod -n "$NS" --context "$CONTEXT" "$1-tidb-0" -o json | jq .status.podIP -r)
	kubectl port-forward -n "$NS" --context "$CONTEXT" "$1-tidb-0" 4000:4000
	echo "mysql -uroot -p$PASS -P 4000 -A -h 127.0.0.1" | tee >(tr -d '\n' | pbcopy)
}

function tidb_mysql_connect() {
	NS="tidb-$1" 
	CONTEXT="m-tidb-$2-ea1-us" 
	PASS=$(kubectl get secret -n "$NS" --context "$CONTEXT" tidb-secret -o json | jq .data.root -r | base64 -d | tr -d '\n')
	kubectl port-forward -n "$NS" --context "$CONTEXT" "$1-tidb-0" 4000:4000 &
	bg_pid=$!

	function kill_port_forward() {
		kill "$bg_pid"
	}

	printf "\n"
	sleep 1

	mysql -uroot -"p$PASS" -P 4000 -A -h 127.0.0.1

	# Terminate the first background command
	trap kill_port_forward EXIT
}

function tidb_dmctl_connect() {
	NS="tidb-$1" 
	CONTEXT="m-tidb-$2-ea1-us" 
	DM_POD="$1-dm-master-0" 
	kctl --context "$CONTEXT" -n "$NS" exec -it "$DM_POD" -c dm-master -- bin/sh -c "./dmctl --master-addr https://127.0.0.1:8261 --ssl-cert /var/lib/dm-master-tls/tls.crt --ssl-key /var/lib/dm-master-tls/tls.key --ssl-ca /var/lib/dm-master-tls/ca.crt"
}

function tidb_pdctl_connect() {
	NS="tidb-$1" 
	CONTEXT="m-tidb-$2-ea1-us" 
	PD_POD="$1-pd-0" 
	kctl --context "$CONTEXT" -n "$NS" exec -it "$PD_POD" -c pd -- bin/sh -c "./pd-ctl -u https://127.0.0.1:2379 --cert /var/lib/cluster-client-tls/tls.crt --key /var/lib/cluster-client-tls/tls.key --cacert /var/lib/cluster-client-tls/ca.crt  -i"
}
