# Mekstack infrastructure

## VPNaaS

After deployment you should add security groups for wireguard because by default they are not added

    openstack security group list | grep mekstack | awk '{ print $2 }' | parallel openstack security group rule create --dst-port 30000:32767 --protocol udp --description \'NodePort UDP\'

## Vault

Set origins in CORS headers manually, because tf does not support that

    vault write sys/config/cors allowed_origins="*"
