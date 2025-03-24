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
	COMMAND="mdcli tidb mysql -d ${@}"

	eval "$COMMAND"
}

function tidb_mysql() {
    tidb_mysql_connect "$@"
}

function tmysql() {
    tidb_mysql_connect "$@"
}

function tidb_ticdc_exec() {
	CONTEXT="m-tidb-$1-ea1-us"
	NS="tidb-$2"
	CDC_POD="$2-ticdc-1"
	PD_ENDPOINT="https://$2-pd:2379"
	shift 2

	echo "Connecting to $CDC_POD in $NS on $CONTEXT"
	cmd="kctl --context \"$CONTEXT\" -n "$NS" exec -it \"$CDC_POD\" -c ticdc -- bin/sh -c \"/cdc cli --pd $PD_ENDPOINT --cert /var/lib/cluster-client-tls/tls.crt --key /var/lib/cluster-client-tls/tls.key --ca /var/lib/cluster-client-tls/ca.crt ${@}\""
	echo $cmd
	eval "$cmd"
}

function tidb_dmctl_connect() {
	COMMAND="mdcli tidb dmctl -d ${@}"

	eval "$COMMAND"
}

function tidb_dmctl() {
	tidb_dmctl_connect "$@"
}

function tdmctl() {
	tidb_dmctl_connect "$@"
}

function tidb_pdctl_connect() {
	COMMAND="mdcli tidb pdctl -d ${@}"

	eval "$COMMAND"
}

function tidb_pdctl() {
    tidb_pdctl_connect "$@"
}

function tpdctl() {
    tidb_pdctl_connect "$@"
}

function tidb_kctl() {
	mdcli tidb tkc -d "$@"
}

function tidb_kc() {
	tidb_kctl "$@"
}

function tidbkc() {
	tidb_kctl "$@"
}

function tikc() {
	tidb_kctl "$@"
}

function tkc() {
	tidb_kctl "${@}"
}

function tkcpa() {
	tidb_kctl -c proda "${@}"
}

function tkcpb() {
	tidb_kctl -c prodb "${@}"
}

function tkcpc() {
	tidb_kctl -c prodc "${@}"
}

function tkcsa() {
	tidb_kctl -c stga "${@}"
}

function tkcsb() {
	tidb_kctl -c stgb "${@}"
}

function tkcsc() {
	tidb_kctl -c stgc "${@}"
}

function tkcta() {
	tidb_kctl -c testa "${@}"
}

function tkctb() {
	tidb_kctl -c testb "${@}"
}

function tkctc() {
	tidb_kctl -c testc "${@}"
}

function aurora_mysql_connect() {
	INSTANCE="$1"

	echo "Connecting to Aurora $INSTANCE"
	ssh dbadmin.musta.ch -t "dbadmin_mysql --aurora-ro \"$INSTANCE\""
}

function tidb_k9s() {
	COMMAND="mdcli tidb tk9s -d ${@}"

	eval "$COMMAND"
}

function tidbk9s() {
	tidb_k9s "$@"
}

function tik9s() {
	tidb_k9s "$@"
}

function tk9s() {
	tidb_k9s "$@"
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
