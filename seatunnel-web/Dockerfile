FROM openjdk:8-jdk-alpine

ENV PROJECT_VERSION=1.0.2
ENV SEATUNNEL_HOME=/app

# Expose port
EXPOSE 8801

WORKDIR /app

# Install necessary tools
RUN apk add --no-cache bash wget tar

# Download and extract SeaTunnel Web
RUN wget https://archive.apache.org/dist/seatunnel/seatunnel-web/${PROJECT_VERSION}/apache-seatunnel-web-${PROJECT_VERSION}-bin.tar.gz -O seatunnel-web.tar.gz && \
    tar -zxvf seatunnel-web.tar.gz --strip 1 && \
    rm seatunnel-web.tar.gz

# Create the libs directory
RUN mkdir -p libs

# Download MySQL JDBC driver version 8.0.30
RUN wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.30/mysql-connector-java-8.0.30.jar -P libs/

# Copy the custom application.yml into the container
COPY application.yml conf/application.yml

# Make scripts executable
RUN chmod +x bin/*.sh

RUN bin/download_datasource.sh ${PROJECT_VERSION}

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use the entrypoint script as the CMD
CMD ["sh", "/entrypoint.sh"]