# DVD_Service
DVD Service with a postgresql database a nginx load balancer and two nginx (php) web server. The number of Web Servers are easy scalable.

# Requirements
virtualbox
vagrant
minimum 4 GB RAM

# Install requirements on Ubuntu
sudo apt install virtualbox -y
sudo apt install vagrant -y

# Start Service
change in the directory of the cloned repository
```
cd <directory_of_repository>
```
start service with vagrant up
```
vagrant up
```
if you change something in the playbook, run
```
vagrant up --provision
```
to start the virtual machines with the new playbook

# Stop Service
Stop the service with
```
vagrant suspend
```

# Changes while Service is running
if the playbook changes while the virtual machines are running, run
```
vagrant provision
```

# Destroy Service
Destroy all virtual machines with
```
vagrant destroy
```
