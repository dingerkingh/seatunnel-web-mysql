# mysql/Dockerfile
FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=123456
ENV MYSQL_DATABASE=seatunnel

# Install curl and tar using microdnf
RUN microdnf install -y curl tar gzip

# Download and place SQL scripts into /docker-entrypoint-initdb.d
RUN curl -L https://archive.apache.org/dist/seatunnel/seatunnel-web/1.0.2/apache-seatunnel-web-1.0.2-bin.tar.gz -o seatunnel-web.tar.gz && \
    tar -zxvf seatunnel-web.tar.gz && \
    mv apache-seatunnel-web-1.0.2-bin/script/seatunnel_server_mysql.sql /docker-entrypoint-initdb.d/ && \
    rm -rf apache-seatunnel-web-1.0.2-bin seatunnel-web.tar.gz

# Set the correct permissions
RUN chmod -R 755 /docker-entrypoint-initdb.d

