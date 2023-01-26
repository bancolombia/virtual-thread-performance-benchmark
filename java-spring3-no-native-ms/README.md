## Spring boot 3

[Spring native image](https://docs.spring.io/spring-boot/docs/current/reference/html/native-image.html) |
[Spring native intro](https://www.baeldung.com/spring-native-intro)

```sh
gradle bootJar
gradle bootBuildImage

docker run --rm -p 8080:8080 docker.io/library/<name>:<version>
docker run --rm -p 8080:8080 docker.io/library/spring:0.0.1-SNAPSHOT

docker history docker.io/library/spring:0.0.1-SNAPSHOT
```

#### Add Native Support
```gradle
plugins {
    //...
    id 'org.graalvm.buildtools.native' version '0.9.18'
}
```

#### Native compile
```sh
# sdk install java 22.3.r19-grl

gradle nativeCompile
```

#### Dockerfile
```sh
## Build
FROM ghcr.io/graalvm/graalvm-ce:latest AS build
WORKDIR /app
COPY . .
RUN ./gradlew nativeCompile

## Deploy
FROM fedora
WORKDIR /app
COPY --from=build /app/build/native/nativeCompile/spring /app/spring
CMD [ "/app/spring" ]
```

```sh
docker build --tag sss:latest .
docker run --rm -p 8080:8080 sss:latest
```
