

Docker-Compose installation 

1) Run this command to download the current stable release of Docker Compose:
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
2) Apply executable permissions to the binary:
 	sudo chmod +x /usr/local/bin/docker-compose

Note;
If the command docker-compose fails after installation, check your path. You can also create a symbolic link to /usr/bin or any other directory in your path.
For example:
$ sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

3) Optionally, install command completion for the bash and zsh shell.
4) Test the installation.
 	 $docker-compose --version

Upgrading🔗
If you’re upgrading from Compose 1.2 or earlier, remove or migrate your existing containers after upgrading Compose. This is because, as of version 1.3, Compose uses Docker labels to keep track of containers, and your containers need to be recreated to add the labels.
If Compose detects containers that were created without labels, it refuses to run, so that you don’t end up with two sets of them. If you want to keep using your existing containers (for example, because they have data volumes you want to preserve), you can use Compose 1.5.x to migrate them with the following command:
$ docker-compose migrate-to-labels
Alternatively, if you’re not worried about keeping them, you can remove them. Compose just creates new ones.
$ docker container rm -f -v myapp_web_1 myapp_db_1 ...
Uninstallation🔗
To uninstall Docker Compose if you installed using curl:
$ sudo rm /usr/local/bin/docker-compose
To uninstall Docker Compose if you installed using pip:
$ pip uninstall docker-compose
Got a “Permission denied” error?
If you get a “Permission denied” error using either of the above methods, you probably do not have the proper permissions to remove docker-compose. To force the removal, prepend sudo to either of the above commands and run again.




