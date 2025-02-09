---
title: "Testing setup for iptables through Docker"
description: "Learning iptables with docker"
date: "2025-02-06"
slug: "iptables-in-docker"
tags:
  - "devbot"
draft: false
showToc: true
TocOpen: false
hidemeta: false
comments: false
# canonicalURL: "https://canonical.url/to/page"
# disableHLJS: false # to disable highlightjs
disableShare: false
hideSummary: false
searchHidden: true
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true
# cover:
#   image: "<image path/url>" # image path/url
#   alt: "<alt text>" # alt text
#   caption: "<text>" # display caption under cover
#   relative: false # when using page bundles set this to true
#   hidden: true # only hide on current single page
# editPost:
#   URL: "https://github.com/<path_to_repo>/content"
#   Text: "Suggest Changes" # edit text
#   appendFilePath: true # to append file path to Edit link
---
There is a way to locally get some experience with iptables, and to get a testable environment. 
This is easily achieved with a simple docker container.

We'll dive right in with the dockerfile and commands to get this running:

``` Dockerfile
FROM debian:latest

# Install iptables and net-tools (for testing with ping, netstat, etc.). Install python3 to start web-servers
RUN apt-get update && \
    apt-get install -y iptables net-tools iproute2 iputils-ping python3 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Allow IPv4 forwarding (useful if testing NAT)
RUN echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
```

The last command is just for illustration. This part will not delve deeper into testing NAT setups.

We'll first build this container:
`docker build . -t iptables-learn`

Then run it:
`docker run -it --name iptables --privileged iptables-learn`

Your shell will change, since you're now running in the container. This is the shell where we can run our iptables-commands.
Now we can open another shell for our local computer that is running the container. For our testing we need the ip address for the container. We can get this by using `docker inspect iptables | grep IP`
Let's assume that the IP is `172.17.0.2`

You can now use a second shell and use `nc -zv 172.17.0.2 80` and...

```bash
nc: connect to 172.17.0.2 port 80 (tcp) failed: Connection refused
```

Wait..We didn't set up any rules. This should work..

For a port to work, there needs to be a listening side. Most of the time this is a webserver like ngingx, or some reverse proxy that can forward specific host requests. 
This is why we installed python3, which has a built-in webserver.
In the iptables-container, we run the following command:
`python3 -m http.server 80 &`

We can not test the command again and (normally) get the following:
`Connection to 172.17.0.2 80 port [tcp/http] succeeded!`

You can change the port at the end to test other ports as well, just make sure that there is a service listening on the port that you are blocking through iptables.
`Connection to 172.17.0.2 1234 port [tcp/*] succeeded!`

> [!Important] the python3 &-command
> The `&` at the end of `python3 -m http.server 80` makes it a background task.</br>
> Check your tasks with the `jobs` command.</br>
> Bring them back forward with the `fg` command.

## Testing iptables basics

We just started a http server on port 80, and this one succeeded. We're going to do three things:

1. We're going to open up SSH port 22, just because it's something that you will do a lot.
2. We're going to open up access for localhost
3. We're going to block all other access, including port 80
4. And last: we'll open up the access to port 80 to let our http traffic through. We are going to insert this rule.

So we now go to the terminal in the docker image and we can use the following rules.

``` bash
iptables -A INPUT -i lo -j ACCEPT             # Accept localhost
iptables -A INPUT -p tcp --dport 22 -j ACCEPT # Accept SSH
iptables -A INPUT -j DROP                     # Drop all other traffic
```

We can list our current rules with the command `iptables -L --line-numbers`.
You can now test the command to see if your port 80 is open:

``` bash
jens@Valkyrie  ~/Workspace/iptables-test-jens  nc -zv 172.17.0.2 80
nc: connect to 172.17.0.2 port 80 (tcp) failed: Connection timed out
```

Because rules are evaluated line by line, there is no use in appending to the iptables.
The traffic will be dropped in line 3 either way.
We will have to insert the new rule before the third line:

``` bash
iptables -I INPUT 3 -p tcp --dport 80 -j ACCEPT
```

 A new quick test on the host machine yields a fast result:

 ``` bash
  ✘ jens@Valkyrie  ~/Workspace/iptables-test-jens  nc -zv 172.17.0.2 80
Connection to 172.17.0.2 80 port [tcp/http] succeeded!
 ```
