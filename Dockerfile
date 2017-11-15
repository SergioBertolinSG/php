FROM owncloud/ubuntu:16.04
MAINTAINER ownCloud DevOps <devops@owncloud.com>

RUN apt-get update -y && \
  apt-get install -y software-properties-common language-pack-en-base

RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php && \
  apt-get update -y && \
  apt-get install -y git-core unzip npm nodejs-legacy wget fontconfig php5.6 php5.6-xml php5.6-mbstring php5.6-curl php5.6-gd php5.6-zip php5.6-intl php5.6-sqlite3 php5.6-mysql php5.6-pgsql php5.6-soap php5.6-phpdbg php-pear && \
  apt-get install -y php-redis php-memcached php-imagick && \
  apt-get upgrade -y && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#ORACLE INSTALLATION
#get the zips
RUN mkdir /opt/oracle && \
wget -O /opt/oracle/instantclient-basic-linux.x64-12.1.0.2.0.zip \
https://github.com/DeepDiver1975/oracle_instant_client_for_ubuntu_64bit\
/raw/12.1.as.zip/zips/instantclient-basic-linux.x64-12.1.0.2.0.zip && \
 wget -O /opt/oracle/instantclient-sdk-linux.x64-12.1.0.2.0.zip \
https://github.com/DeepDiver1975/oracle_instant_client_for_ubuntu_64bit\
/raw/12.1.as.zip/zips/instantclient-sdk-linux.x64-12.1.0.2.0.zip && \
 wget -O /opt/oracle/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip \
https://github.com/DeepDiver1975/oracle_instant_client_for_ubuntu_64bit\
/raw/12.1.as.zip/zips/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip

#unzip them
RUN unzip /opt/oracle/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /opt/oracle && \
unzip /opt/oracle/instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /opt/oracle && \
unzip /opt/oracle/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip -d /opt/oracle

#set paths properly (?)
RUN ln -s /opt/oracle/instantclient_12_1/libclntsh.so.12.1 /opt/oracle/instantclient_12_1/libclntsh.so && \
ln -s /opt/oracle/instantclient_12_1/libocci.so.12.1 /opt/oracle/instantclient_12_1/libocci.so && \
echo /opt/oracle/instantclient_12_1 > /etc/ld.so.conf.d/oracle-instantclient && \
ldconfig

RUN pecl install oci8

#add extension to php.ini




RUN curl -sS https://getcomposer.org/installer \
  | php -- --install-dir=/usr/bin --filename=composer
