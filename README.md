# rpi-johnny-five
This is a Docker container that can be used as a base to create NodeJS apps based on Johnny Five for interacting with Arduino (with Standard Firmata) that runs on Raspberry PI. Inside you will find Python 2.7, NodeJS, npm and all Johnny Five dependencies ready for ARM.

Use "FROM flaviostutz/rpi-johnny-five" on your Dockerfile

# Developers

You can connect to the container using SSH in order to test your code locally so that you avoid buiding the container at each run:
 - Start the container with "docker run -it --privileged -p 2222:22 flaviostutz/rpi-johnny-five" on your Raspberry connected to Arduino
 - Connect to container using "ssh root@[raspberry ip]:2222" (password is "root")
 - Checkout you repository inside the container (you have git there!)
 - Code using nano or vi (!!!)
 - Run your node script and see what happens

My preferred way of coding to Raspberry containers is to mount the filesystem of the container to my local machine so that I can use my graphic tools:
 - Start the container with "docker run -it --privileged -p 2222:22 flaviostutz/rpi-johnny-five" on your Raspberry connected to Arduino
 - Install "sshfs" on your local machine (available for Linux and MacOS)
 - Mount the container filesystem to your machine doing "sshfs root@[raspberryip]:/opt /whatever/container -p 2222"
 - Put your code to /whatever/container and use your tools there
 - Connect to container using "ssh root@[raspberry ip]:2222" (password is "root")
 - Run your code (node /opt/test.js and so on)
 - I use to checkout my git repository inside the container. You can "git commit" from the inside or from your machine. Both works :)
 - When code is ready perform the container build from the outside
 - On Windows you can use SFTP Net Drive (https://www.eldos.com/sftp-net-drive/download-release.php) for directory mounting
