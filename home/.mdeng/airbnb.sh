function tidb_mysql_cmd() {
	CONTEXT="m-tidb-$1-ea1-us" 
	NS="tidb-$2" 
	PASS=$(kubectl get secret -n "$NS" --context "$CONTEXT" tidb-secret -o json | jq .data.root -r | base64 -d | tr -d '\n')
	IP=$(kubectl get pod -n "$NS" --context "$CONTEXT" "$2-tidb-0" -o json | jq .status.podIP -r)
	echo "mysql -uroot -p$PASS -P 4000 -A -h $IP" | tee >(tr -d '\n' | pbcopy)
}

function tidb_mysql_local_cmd() {
	CONTEXT="m-tidb-$1-ea1-us" 
	NS="tidb-$2" 
	PASS=$(kubectl get secret -n "$NS" --context "$CONTEXT" tidb-secret -o json | jq .data.root -r | base64 -d | tr -d '\n')
	IP=$(kubectl get pod -n "$NS" --context "$CONTEXT" "$2-tidb-0" -o json | jq .status.podIP -r)
	kubectl port-forward -n "$NS" --context "$CONTEXT" "$2-tidb-0" 4000:4000
	echo "mysql -uroot -p$PASS -P 4000 -A -h 127.0.0.1" | tee >(tr -d '\n' | pbcopy)
}

function tidb_mysql_connect() {
	CONTEXT="m-tidb-$1-ea1-us" 
	NS="tidb-$2" 
	POD_NUM=${3:-0}
	TIDB_POD="$2-tidb-$POD_NUM"
	PASS=$(kubectl get secret -n "$NS" --context "$CONTEXT" tidb-secret -o json | jq .data.root -r | base64 -d | tr -d '\n')
	kubectl port-forward -n "$NS" --context "$CONTEXT" "$TIDB_POD" 4000:4000 &
	bg_pid=$!

	function kill_port_forward() {
		kill "$bg_pid"
	}

	printf "\n"
	sleep 1

	echo "Connecting to mysql on $2-tidb-$POD_NUM in $NS on $CONTEXT"
	mysql -uroot -"p$PASS" -P 4000 -A -h 127.0.0.1

	# Terminate the first background command
	trap kill_port_forward EXIT
}

function tidb_dmctl_connect() {
	CONTEXT="m-tidb-$1-ea1-us" 
	NS="tidb-$2" 
	DM_POD="$2-dm-master-0" 

	echo "Connecting to $DM_POD in $NS on $CONTEXT"
	kctl --context "$CONTEXT" -n "$NS" exec -it "$DM_POD" -c dm-master -- bin/sh -c "./dmctl --master-addr https://127.0.0.1:8261 --ssl-cert /var/lib/dm-master-tls/tls.crt --ssl-key /var/lib/dm-master-tls/tls.key --ssl-ca /var/lib/dm-master-tls/ca.crt"
}

function tidb_pdctl_connect() {
	CONTEXT="m-tidb-$1-ea1-us" 
	NS="tidb-$2" 
	PD_POD="$2-pd-0" 

	echo "Connecting to $PD_POD in $NS on $CONTEXT"
	kctl --context "$CONTEXT" -n "$NS" exec -it "$PD_POD" -c pd -- bin/sh -c "./pd-ctl -u https://127.0.0.1:2379 --cert /var/lib/cluster-client-tls/tls.crt --key /var/lib/cluster-client-tls/tls.key --cacert /var/lib/cluster-client-tls/ca.crt  -i"
}

function tidb_kctl() {
	CONTEXT="m-tidb-$1-ea1-us" 
	NS="tidb-$2" 

	COMMAND="kctl --context \"$CONTEXT\" -n \"$NS\" ${@:3}"

	if [ -t 1 ]; then
		echo "$COMMAND"
	fi
	eval "$COMMAND"
}

function tidb_kc() {
	tidb_kctl "$@"
}

function aurora_mysql_connect() {
	INSTANCE="$1"

	echo "Connecting to Aurora $INSTANCE"
	ssh dbadmin.musta.ch -t "dbadmin_mysql --aurora-ro \"$INSTANCE\""
}

function tidb_k9s() {
	CONTEXT="m-tidb-$1-ea1-us"
	NS="tidb-$2"

	shift 2
	COMMAND="k9s --context \"$CONTEXT\" -n \"$NS\" $@"
	if [ -t 1 ]; then
		echo "$COMMAND"
	fi
	eval "$COMMAND"
}

function aws_select_role() {
	eval $(aws-creds select-role)
}

function gh_prs() {
        prs=$(gh search prs --team-mentions "airbnb/tidb-dev" --state open --json number,title,author,url,repository)
        pr=$(echo "$prs" | jq -r '.[] | [.number, .title, .author.login, .repository.name, .url] | @tsv' | fzf)
        pr_url=$(echo "$pr" | cut -f5)
        open "$pr_url"
}

function tidb_tmux() {
	tmuxinator start abb-tidb --no-attach && \
	tmuxinator start abb-k8s --no-attach && \
	tmuxinator start abb-tidb-tools --no-attach && \
	tmuxinator start abb-tidb-upstream --no-attach && \
	tmuxinator start abb-tidb-infra --no-attach
	mdcli tmux layout -s abb-tidb && \
	mdcli tmux layout -s abb-k8s && \
	mdcli tmux layout -s abb-tidb-tools && \
	mdcli tmux layout -s abb-tidb-upstream && \
	mdcli tmux layout -s abb-tidb-infra
}
