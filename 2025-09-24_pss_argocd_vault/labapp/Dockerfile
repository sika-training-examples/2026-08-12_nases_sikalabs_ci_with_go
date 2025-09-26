FROM openjdk:21-jdk AS build
WORKDIR /build
COPY . .
RUN sh ./mvnw -DskipTests clean package

FROM openjdk:21-jdk
VOLUME /tmp
COPY --from=build /build/target/*.jar /app.jar
EXPOSE 8080
HEALTHCHECK --start-period=5m --interval=15s --timeout=5s --retries=3 CMD curl http://127.0.0.1:8080/actuator/health || exit 1
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS $APM_OPTS -jar /app.jar"]
