FROM centos

MAINTAINER iiichtang

RUN yum update -y

RUN yum install -y java-1.8.0 \
wget \
unzip

RUN mkdir -p /middleware

RUN (cd /middleware && wget https://s3-ap-northeast-1.amazonaws.com/itrimiddleware/middleware.zip)

RUN (cd /middleware && unzip ./middleware.zip)

RUN (cd /middleware && rm middleware.zip)

EXPOSE 1099
EXPOSE 8082
EXPOSE 8852
EXPOSE 8853
EXPOSE 8854

CMD RMI_HOST=`wget -q -O - http://169.254.169.254/latest/meta-data/public-hostname` && cd /middleware && java -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=1099 -Dcom.sun.managent.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=$RMI_HOST -Dcom.sun.management.jmxremote.rmi.port=1099 -cp SocketServerConsole.jar fy103.Main ./config.xml

#for testing