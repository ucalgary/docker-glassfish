# GlassFish 3.1.2.2 with OpenJDK 7 on Alpine
# Based on both glassfish and oracle/glassfish in Docker Hub

FROM java:7-jdk-alpine

MAINTAINER King Chung Huang <kchuang@ucalgary.ca>

# Set environment variables and default password for user 'admin'
ENV GLASSFISH_PKG=/tmp/glassfish-3.1.2.2-web.zip \
    GLASSFISH_URL=http://download.java.net/glassfish/3.1.2.2/release/glassfish-3.1.2.2-web.zip \
    GLASSFISH_HOME=/usr/local/glassfish3 \
    MD5=ae8e17e9dcc80117cb4b39284302763f \
    PATH=$PATH:/usr/local/glassfish3/bin \
    PASSWORD=Gla55F1sh4dm1n

# Install packages, download and extract GlassFish
# Setup password file
# Enable DAS
RUN wget -q -O $GLASSFISH_PKG $GLASSFISH_URL && \
    echo "$MD5 *$GLASSFISH_PKG" | md5sum -c - && \
    unzip -o $GLASSFISH_PKG -d /usr/local && \
    rm -f $GLASSFISH_PKG && \
    echo "--- Setup the password file ---" && \
    echo "AS_ADMIN_PASSWORD=" > /tmp/glassfishpwd && \
    echo "AS_ADMIN_NEWPASSWORD=${PASSWORD}" >> /tmp/glassfishpwd  && \
    echo "--- Enable DAS, change admin password, and secure admin access ---" && \
    asadmin --user=admin --passwordfile=/tmp/glassfishpwd change-admin-password --domain_name domain1 && \
    asadmin start-domain && \
    echo "AS_ADMIN_PASSWORD=${PASSWORD}" > /tmp/glassfishpwd && \
    asadmin --user=admin --passwordfile=/tmp/glassfishpwd enable-secure-admin && \
    asadmin --user=admin stop-domain && \
    rm /tmp/glassfishpwd

# Ports being exposed
EXPOSE 4848 8080 8181

WORKDIR /usr/local/glassfish3

# Start asadmin console and the domain
CMD ["asadmin", "start-domain", "-v"]
