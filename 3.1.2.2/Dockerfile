# GlassFish 3.1.2.2 with OpenJDK 7 on Alpine
# Based on both glassfish and oracle/glassfish in Docker Hub

FROM java:7-jdk-alpine

MAINTAINER King Chung Huang <kchuang@ucalgary.ca>

# Set environment variables and default password for user 'admin'
ENV GLASSFISH_PKG=/tmp/glassfish-3.1.2.2.zip \
    GLASSFISH_URL=http://download.java.net/glassfish/3.1.2.2/release/glassfish-3.1.2.2.zip \
    GLASSFISH_HOME=/usr/local/glassfish3 \
    MD5=ae8e17e9dcc80117cb4b39284302763f \
    PATH=$PATH:/usr/local/glassfish3/bin

# Download and install GlassFish
RUN wget -q -O $GLASSFISH_PKG $GLASSFISH_URL && \
    echo "$MD5 *$GLASSFISH_PKG" | md5sum -c - && \
    unzip -o $GLASSFISH_PKG -d /usr/local && \
    rm -f $GLASSFISH_PKG && \

# Ports being exposed
EXPOSE 4848 8080 8181

WORKDIR /usr/local/glassfish3

# Start asadmin console and the domain
CMD ["asadmin", "start-domain", "-v"]
