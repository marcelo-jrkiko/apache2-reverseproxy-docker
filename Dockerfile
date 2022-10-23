# Clic Sistemas - DataCenter
# ReverseProxy Server Image
FROM httpd:latest

# Copia os Arquivos
COPY ./Apache2/ /usr/local/apache2/conf/
COPY ./ask-for-passphrase /usr/share/apache2/ask-for-passphrase

# Cria a Pasta de Armazenamento
RUN mkdir -p /storage
RUN mkdir -p /var/log/apache2
RUN mkdir -p /var/lock/apache2
RUN mkdir -p /var/lock/apache2/ssl_mutex

# Variaveis de Ambiente
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_RUN_DIR /var/run/apache2 
ENV APACHE_LOCK_DIR /var/lock/apache2 

# Instala os Modulos Adicionais
RUN apt-get update 
RUN apt-get install libapache2-mod-bw -y

RUN a2enmod bw 

# Porta
EXPOSE 80

CMD ["httpd", "-D", "FOREGROUND"]