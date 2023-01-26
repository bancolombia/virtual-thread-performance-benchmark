FROM gradle:jdk17-alpine
WORKDIR /app
COPY . .
RUN gradle bootJar


FROM openjdk:17-alpine
WORKDIR /app
COPY --from=0 /app/build/libs/spring-0.0.1-SNAPSHOT.jar /app/spring-0.0.1-SNAPSHOT.jar

ENV JAVA_OPTS="-XX:+UseContainerSupport"
ENTRYPOINT ["sh","-c","java $JAVA_OPTS -jar spring-0.0.1-SNAPSHOT.jar"]