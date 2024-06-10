FROM centos
LABEL maintainer="vikash@gmail.com"

# Update yum repositories and install dependencies
RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' CentOS-* && \
    yum -y install java httpd zip unzip wget && \
    yum clean all

# Download photogenic.zip using wget
RUN cd /var/www/html/ && \
    wget -q https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip && \
    unzip -q photogenic.zip && \
    rm -f photogenic.zip

# Set working directory and expose port
WORKDIR /var/www/html/
EXPOSE 80

# Start Apache HTTP Server
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
