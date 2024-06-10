FROM centos
LABEL maintainer="roisthomas088@gmail.com"

# Update yum repositories and install dependencies
RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' CentOS-* && \
    yum -y install java httpd zip unzip

# Add the template and unzip it
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip -q photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

# Expose port 80 and start Apache HTTP Server
EXPOSE 80 22
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
