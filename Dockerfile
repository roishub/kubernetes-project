FROM centos
LABEL maintainer="vikash@gmail.com"

# Update yum repositories and install dependencies
RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' CentOS-* && \
    yum -y install java httpd zip unzip

# Add the template and unzip it
ADD https://www.free-css.com/assets/files/free-css-templates/download/page228/elegance.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip -q elegance.zip && \
    cp -rvf elegance/* . && \
    rm -rf elegance elegance.zip

# Expose port 80 and start Apache HTTP Server
EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
