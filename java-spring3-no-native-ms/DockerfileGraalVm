##
## Build
##
FROM ghcr.io/graalvm/graalvm-ce:latest AS build
WORKDIR /app
COPY . .
RUN ./gradlew nativeCompile

##
## Deploy
##
FROM fedora
WORKDIR /app
COPY --from=build /app/build/native/nativeCompile/spring /app/spring
CMD [ "/app/spring" ]
