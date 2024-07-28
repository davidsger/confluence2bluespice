FROM ubuntu:20.04
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
WORKDIR /confluence
RUN apt-get update
RUN apt-get -y install php7.4
RUN apt-get -y install php-xml
RUN apt-get -y install pandoc
RUN apt-get -y install wget
RUN apt-get -y install curl
RUN apt-get -y install unzip
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer selfupdate 2.3.0

#RUN wget https://raw.githubusercontent.com/hallowelt/migrate-confluence/main/bin/mi$
RUN apt-get -y install git
#RUN git clone https://github.com/hallowelt/migrate-confluence.git
RUN wget https://github.com/hallowelt/migrate-confluence/archive/refs/tags/1.2.2.zip
RUN unzip 1.2.2.zip
RUN mv migrate-confluence-1.2.2 migrate-confluence
RUN chmod +x migrate-confluence/bin/migrate-confluence
#RUN cp migrate-confluence /bin/migrate-confluence
RUN ln -s "${PWD}/migrate-confluence/bin/migrate-confluence" /bin/migrate-confluence
RUN cd migrate-confluence && composer install

RUN mkdir /project
WORKDIR /project

ENTRYPOINT ["/bin/bash"]
