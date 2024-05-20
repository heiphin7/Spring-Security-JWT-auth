# build project
FROM maven:3.8.4-openjdk-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=builder /app/target/security-0.0.1-SNAPSHOT.jar app.jar
CMD ["java", "-jar", "app.jar"]