. shim.sh

vpt-az-login
vpt-azure-group-create
vpt-azure-relay-create
vpt-ssh-start
vpt-azbridge-remote-start
vpt-azbridge-local-start; sleep 1
vpt-ssh-azure-relay-proxy-start; sleep 1
vpt-az-proxy-enable
vpt-demo
vpt-az-proxy-disable

kill %+; sleep 1
kill %+; sleep 1
kill %+

vpt-azure-relay-delete
