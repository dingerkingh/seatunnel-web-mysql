#!/bin/sh
set -ex

echo "Script execution started"

sleep 5

echo "Waiting for connectors to be available in /shared-connectors/..."
while [ "$(ls -A /shared-connectors 2>/dev/null)" = "" ]; do
    sleep 1
done

echo "Connectors found, copying to /app/libs/"
cp -r /shared-connectors/. /app/libs/

echo "Starting Java application"
exec java -server -Xms1g -Xmx1g -Xmn512m \
    -XX:+PrintGCDetails -XX:+HeapDumpOnOutOfMemoryError \
    -XX:HeapDumpPath=dump.hprof -Xloggc:/app/logs/gc.log \
    -Dseatunnel-web.logs.path=/app/logs \
    -Dspring.config.name=application.yml \
    -Dspring.config.location=classpath:application.yml \
    -cp /app/conf:/app/libs/*:/app/datasource/* \
    org.apache.seatunnel.app.SeatunnelApplication

echo "Script execution ended"  # This line should not execute due to 'exec' above
