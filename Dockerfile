FROM eclipse-temurin:21-jdk-jammy AS build
WORKDIR /app
COPY . .
RUN mvn clean package -pl BolnicaWeb -am -DskipTests --no-transfer-progress

FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY --from=build /app/BolnicaWeb/target /tmp/build
RUN find /tmp/build -maxdepth 1 -name '*.jar' ! -name '*-plain.jar' \
    -exec mv {} /app/app.jar \; && rm -rf /tmp/build
EXPOSE 8080
ENTRYPOINT ["java", "-Dserver.port=${PORT:-8080}", "-jar", "app.jar"]