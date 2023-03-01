# Run a Docker Radiant Node

##Installing Docker:
The process for installing docker engine depends on your operating system. 
Refer to https://docs.docker.com/engine/install/ and look up instructions for your OS.

##Pulling Docker image:
You can browse https://hub.docker.com/ for images that you might find use for. Here we will be using the image found here: 
https://hub.docker.com/r/radiantcommunity/radiant-node.
Under Docker commands you can see a command to fetch the image so that you store it locally. 
If you know what image you want there is no need to do this manually. 
When we run the image and Docker can't find it locally it will search Docker Hub for it.

##Running the container:
The command for running the image we use here is:

```
sudo docker run --name radiantnode -itd radiantcommunity/radiant-node
```

You might not need to sudo if you have given docker sudo rights. 
The -itd tag is to run the container interactively, with tty (terminal) and detatched (background). 
The last bit is the reference to the image you want to run.

The name tag is optional, but makes it easier when we specify it when we want to inspect the container and when we stop it.

When you run the command you should see a hash, and that means the container started.

##Inspecting the container:
You can run this to see what containers are currently running:

```
sudo docker ps
```

and you can run this to see all containers that has been ran:

```
sudo docker ps -a
```

Acces the container to inspect and troubleshoot:
We can access the terminal of the running container to inspect and troubleshoot it using this command:

```
sudo docker exec -it radiantnode sh
```

This will open up the terminal in the container and we can run commands to see that everything runs as expected. 
For example we can run: 

```
radiant-cli -getinfo 
```

to see that our node is running.
You can see other useful commands to run on the node in the radiant node guide (https://radiant4people.com/guides/node/compile/#useful-commands).

We now have a functional radiant node up and running, but why stop there? 
We can easilly run multiple nodes at once. Just start another node using the same image (but different name). 
This will spawn a new container with a new node running. For example:

```
sudo docker run --name radiantnode2 -itd radiantcommunity/radiant-node
```

We can now use

```
sudo docker ps
```

to see that we have two nodes running.

##Stopping container:
When its time to stop the container we simply run: 

```
sudo docker stop radiantnode
```

"radiantnode" is the name we specified when we started the first container. to stop the second container we started:

```
sudo docker stop radiantnode2
```
