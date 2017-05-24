---
title: Mount a Windows folder as a volume in Docker when using VirtualBox
description: Mount a Windows folder as a volume in Docker when using VirtualBox
header: Share a Windows folder with a Docker Container
---

This only applies to running Docker on Windows 7 or older using VirtualBox to run the Docker host VM.

## Share the directory in Windows with the Docker Host
<br/>

* Open VirtualBox Manager.
* The Docker Host VM is called "default". Open Settings for this VM.
* Go to the "Shared Folders" panel and add the directory you want to access from your Docker Container.

## Run the Docker Container mounting the volume

> docker run -it -v [/path/to/shared/folder/in/docker/host]:[/path/in/container] [image-name] sh

An example could be the following command to allow me to use Ansible Vault to encrypt files on my Windows machine without having to install Ansible. I follow the steps above to map C:\\Development to /Development/ in the VirtualBox Docker Host. I then run the below command to run the Docker Container mounting the shared folder as a Volume in the container and launching keeping the command line open for further Ansible commands to be run.

> docker run -it -v /Development/vault/:/vault ansible/centos7-ansible sh

&nbsp;
