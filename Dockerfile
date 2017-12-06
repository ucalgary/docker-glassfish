FROM openjdk:7u151-jdk-alpine

# Set environment variables
ENV GLASSFISH_PKG=/tmp/glassfish-3.1.2.2.zip \
    GLASSFISH_URL=http://download.oracle.com/glassfish/3.1.2.2/release/glassfish-3.1.2.2.zip \
    GLASSFISH_HOME=/usr/local/glassfish3 \
    MD5=ae8e17e9dcc80117cb4b39284302763f \
    PATH=$PATH:/usr/local/glassfish3/bin

# Download and install GlassFish
RUN wget -q -O $GLASSFISH_PKG $GLASSFISH_URL && \
    echo "$MD5 *$GLASSFISH_PKG" | md5sum -c - && \
    unzip -o $GLASSFISH_PKG -d /usr/local && \
    rm -f $GLASSFISH_PKG && \
    \
    # Remove Windows .bat and .exe files to save space
    cd $GLASSFISH_HOME && \
    find . -name '*.bat' -delete && \
    find . -name '*.exe' -delete

# Ports being exposed
EXPOSE 4848 8080 8181

WORKDIR /usr/local/glassfish3

# Copy in and set the entrypoint
COPY docker-entrypoint.sh $GLASSFISH_HOME/
ENTRYPOINT ["/usr/local/glassfish3/docker-entrypoint.sh"]

# Start the GlassFish domain
CMD ["asadmin", "start-domain", "--verbose"]

LABEL maintainer="King Chung Huang <kchuang@ucalgary.ca>" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.name="GlassFish" \
      org.label-schema.version="3.1.2.2" \
      org.label-schema.url="https://glassfish.java.net" \
      org.label-schema.vcs-url="https://github.com/ucalgary/docker-glassfish"
