# Dockerfile for vc-assistant

FROM openjdk:11-jre-slim

WORKDIR /app

COPY build/libs/senna.jar .

EXPOSE 8080

CMD ["java", "-jar", "senna.jar"]
