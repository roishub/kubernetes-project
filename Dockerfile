FROM centos
LABEL maintainer="vikash@gmail.com"

# Update yum repositories and install dependencies
RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' CentOS-* && \
    yum -y install java httpd zip unzip

# Attempt to download and unzip the file, handle failure gracefully
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
WORKDIR /var/www/html/
RUN wget --quiet --tries=3 --timeout=10 --waitretry=2 https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip || \
    { echo "Failed to download photogenic.zip"; exit 1; }
RUN unzip -q photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip || \
    { echo "Failed to unzip photogenic.zip"; exit 1; }

# Expose port 80 and start Apache HTTP Server
EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
