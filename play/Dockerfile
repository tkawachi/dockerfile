FROM bradrydzewski/scala:2.10.3
MAINTAINER Takashi Kawachi <tkawachi@gmail.com>

# Use OpenJDK 1.7
RUN sudo update-java-alternatives -s java-1.7.0-openjdk-amd64

# Install utility commands
RUN sudo apt-get install s3cmd
RUN sudo pip install awscli

# Install Haxe
WORKDIR /tmp
RUN wget -q -c http://www.openfl.org/builds/haxe/haxe-3.1.3-linux-installer.tar.gz
RUN tar xzf haxe-3.1.3-linux-installer.tar.gz
RUN ./install-haxe.sh y
RUN haxelib install jQueryExtern
RUN haxelib install hxopt
WORKDIR /home/ubuntu

