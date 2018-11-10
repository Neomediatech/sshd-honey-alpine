# sshd-honey-alpine
Dockerized version of sshd as honeypot service, based on Alpine Linux

## Usage
You can run this container with this command:  
`docker run -d --name sshd-honey-alpine -p 22:22 neomediatech/sshd-honey-alpine`  

Logs are written inside the container, in /var/log/messages, and on stdout. You can see realtime logs running this command:  
`docker logs -f sshd-honey-alpine`  
`CTRL c` to stop seeing logs.  

If you want to map logs outside the container you can add:  
`-v /folder/path/on-host/logs/:/var/log/`  
Where "/folder/path/on-host/logs/" is a folder inside your host. You have to create the host folder manually.  

You can run it on a compose file like this:  

```
version: '3'  

services:  
  sshd:  
    image: neomediatech/sshd-honey-alpine:latest  
    hostname: sshd-honey  
    ports:  
      - '22:22'  
```
Save on a file and then run:  
`docker stack deploy -c /your-docker-compose-file-just-created.yml sshd-honey`

If you want to map logs outside the container you can add:  
```
    volumes:
      - /folder/path/on-host/logs/:/var/log/
```
Where "/folder/path/on-host/logs/" is a folder inside your host. You have to create the host folder manually.

Save on a file and then run:  
`docker stack deploy -c /your-docker-compose-file-just-created.yml sshd-honey` 
