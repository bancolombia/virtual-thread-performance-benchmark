FROM maven:3.8.7-eclipse-temurin-19-alpine as build
WORKDIR /app
COPY . .
RUN mvn clean package

FROM openjdk:19-jdk-slim
WORKDIR /app
COPY --from=build /app/nima/target ./
ENTRYPOINT ["sh","-c","java --enable-preview -jar java-helidon-nima.jar"]
