FROM bradrydzewski/scala:2.10.3
MAINTAINER Takashi Kawachi <tkawachi@gmail.com>

# Use OpenJDK 1.7
RUN sudo update-java-alternatives -s java-1.7.0-openjdk-amd64

# Install utility commands
RUN sudo apt-get install s3cmd
RUN sudo pip install awscli

# Install Haxe
WORKDIR /tmp
RUN wget -q -c https://gist.githubusercontent.com/tkawachi/69a308f660dc03d631b4/raw/80d303706df6000397ee985fcbfa5de0c8f73fc2/install-haxe.sh
RUN bash install-haxe.sh y
RUN rm install-haxe.sh
RUN haxelib install jQueryExtern
RUN haxelib install hxopt
WORKDIR /home/ubuntu

