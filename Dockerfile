#pulling from ruby docker 2.5-strech (hehe strech ...)
FROM ruby:2.5.0-stretch
#Grabing the one thing we neeeeeeeed
CMD ["apt update; apt install libsodium18"]
#Setting our working directory to something descriptive
WORKDIR /EXPSLOSION
# Copy the current directory contents into the container at /EXPSLOSION
ADD . /EXPSLOSION
#Install ALL THE PACKAGES~!
RUN bundler install
#set our name to something appropriage
ENV NAME roboMegumin
#Oh! and run our core when we launch 
CMD ["ruby","core.rb"]
