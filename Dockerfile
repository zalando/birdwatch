# builder image
FROM registry.opensource.zalan.do/stups/openjdk:latest as builder

WORKDIR /app
COPY . .
RUN ./mvnw --batch-mode package

# final image
FROM registry.opensource.zalan.do/stups/openjdk:latest
MAINTAINER Team Teapot @ Zalando SE <team-teapot@zalando.de>

COPY --from=builder /app/catwatch-backend/target/catwatch-backend.jar /catwatch-backend.jar

EXPOSE 8080
CMD java $JAVA_OPTS $(java-dynamic-memory-opts) -jar /catwatch-backend.jar
