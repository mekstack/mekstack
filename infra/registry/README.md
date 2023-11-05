

export OS_CLOUD=openstack

Clone the repository and go to the directory we need

```
git clone https://github.com/mekstack/mekstack.git
cd mekstack/infra/registry
```


Initialize the Terraform working directory and execute the command to generate a file of changes and display what will change at startup.

```
sudo terraform init
sudo terraform plan
```

Next, run the command below. It builds or modifies infrastructure. The command will show the execution plan and will require a yes or no answer (unless the `--auto-approve` flag is used, with which the command will be executed automatically).

```
sudo terraform apply --auto-approve
```


After everything is created, go to the directory with the ansible script

```
cd docker-registry/
```

In order for our ansible script to execute all instructions on our newly created instances, you need to create a VPN configuration and enable it.

Next, we exexute:

```
sudo ansible-playbook deploy-docker-registry.yaml
```

All-in-one
```
sudo terraform init && sudo terraform apply --auto-approve && cd docker-registry/ && sleep 25 && sudo ansible-playbook deploy-docker-registry.yaml
```

Аfter the script is executed, we can safely go to the instances and use docker registers.

## Docker Registry

**Docker Registry** is a tool for storing and sharing docker images.
Let's try to send your image to the newly created repository (docker register). To do this, we need to prostheticize the image. Let's take for example any of your images (we will have an nginx image)

```
sudo docker tag nginx:latest <host ip>:5000/nginx_v1
```

You can specify **localhost:5000**, but then you will not be able to pull this image from another computer on the network. You can also specify the hostname if you have DNS configured.

After that, perform:

`sudo docker push <host ip>:5000/nginx_v1`

The console output will be something like this:

```
The push refers to repository [host_ip:5000/nginx_v1]
Get https://host_ip:5000/v2/: http: server gave HTTP response to HTTPS client
```

The docker utility expects registry to work over a secure HTTPS connection. You can allow connection via an unsecured protocol, for the following line to be added to the docker daemon configuration file:

```
sudo nano /etc/docker/daemon.json

{
    "insecure-registries": ["192.168.0.19:5000"]
}
```

Then restart the docker daemon.

`sudo systemctl restart docker`

Try the push command again.

`sudo docker push <host ip>:5000/nginx_v1`

Your image should be successfully sent to your private repository.
``
To view the list of images in the repository, you can use curl:

`curl -X GET http://<host ip>:5000/v2/_catalog`



Now you can create a **Dockefile** and specify your private repository as the image source.

**Dockefile**

```
FROM <host ip>:5000/nginx:v1
CMD ["uvicorn", "--host", "0.0.0.0", "main:app"]
```

The same can be done with the run command if you just need to run the container, and not use it as a basis.

`sudo docker run -d <host ip>:5000/nginx:v1`