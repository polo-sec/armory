# Docker

## What is a container?
From the Docker documentation, "A container is a standard unit of software that packages up code and all its dependencies, so the application runs quickly and reliably from one computing environment to another. A Docker container image is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries, and settings."

## Why Do Containers Matter?
Containers have networking capabilities and their own file storage. They achieve this by using three components of the Linux kernel:

    Namespaces
    Cgroups
    OverlayFS

But we're only going to be interested in namespaces here; after all, they lay at the heart of it. Namespaces essentially segregate system resources such as processes, files, and memory away from other namespaces.

Every process running on Linux will be assigned a PID and a namespace.

Namespaces are how containerization is achieved! Processes can only "see" the process that is in the same namespace - no conflicts in theory. Take Docker; for example, every new container will be running as a new namespace, although the container may be running multiple applications (and, in turn, processes).

Let's prove the concept of containerization by comparing the number of processes there are in a Docker container that is running a web server versus the host operating system at the time.

We can look for various indicators that have been placed into a container. Containers, due to their isolated nature, will often have very few processes running in comparison to something such as a virtual machine. We can simply use ps aux to print the running processes. Note in the screenshot below that there are very few processes running?

Command used: ps aux 

Containers allow environment variables to be provided from the host operating system by the use of a .dockerenv file. This file is located in the "/" directory and would exist on a container - even if no environment variables were provided.

Command used: cd / && ls -lah

Cgroups are used by containerization software such as LXC or Docker. Let's look for them by navigating to /proc/1 and then catting the "cgroup" file... It is worth mentioning that the "cgroups" file contains paths including the word "docker".
