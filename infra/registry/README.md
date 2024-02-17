## Registry

cd mekstack/mekstack/infra/registry

terraform init
terraform plan

cd docker-registry

ansible-playbook deploy-docker-registry.yaml

-----bug
ssh-keygen -f "/home/ubuntu/.ssh/known_hosts" -R "[172.18.218.180]:2201"
ssh-keygen -f "/home/ubuntu/.ssh/known_hosts" -R "[172.18.218.180]:2201"
----bug