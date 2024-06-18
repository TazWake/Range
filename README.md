# Example Docker Range

## Overview
This is designed to create a quick and simple range with a few docker containers. There is a Kali container that is used to manage an MSFvenom implant (called "binary") stored in the victim container. The nmap container is just there to provide some additional network noise as needed.

## Use

1. Download the files
2. **OPTIONAL** Build the containers via the Dockerfiles using `docker build [path]`
3. Start the range with either: `docker-compose up` or `docker-compose up --build` - this will depend on the state of the images in your repository. 
4. Connect to the Kali container with: `docker exec -it kali-container /bin/bash`
5. SSH into the victim container with `ssh john@localhost -p 2222` using the password `password`.
6. There are two folders mapped to the start location which allow you to switch files between the environment.
7. On completion, use `docker-compose down` to end the containers.

## Note
The target system will run tcpdump to capture all traffic on port 8888 - this is the port the Venom payload has been configured to use.

## Update

This file now includes a Terraform section to spin up instances in AWS.
