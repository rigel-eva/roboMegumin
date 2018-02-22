#pulling from ruby docker 2.5-strech (hehe strech ...)
FROM ruby:2.5.0-stretch
#Grabing the one thing we neeeeeeeed
RUN apt-get update
RUN apt-get install -y libsodium18 libsodium-dev
#Setting our working directory to something descriptive
WORKDIR /EXPSLOSION
# Copy the current directory contents into the container at /EXPSLOSION
ADD . /EXPSLOSION
#Make sure we actualy have bundler ... 
RUN gem install bundler
#Install ALL THE PACKAGES~!
RUN bundler install
#set our name to something appropriage
ENV NAME roboMegumin
#Oh! and run our core when we launch 
CMD ["ruby","core.rb"]
