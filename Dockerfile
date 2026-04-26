FROM eclipse-temurin:21-jdk-jammy AS build
WORKDIR /app
COPY . .
RUN mvn clean package -pl BolnicaWeb -am -DskipTests --no-transfer-progress

FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
# find umjesto hardkodovanog naziva — radi bez obzira na verziju
RUN --mount=type=bind,from=build,source=/app/BolnicaWeb/target,target=/src \
    find /src -maxdepth 1 \( -name '*.jar' -o -name '*.war' \) \
    ! -name '*-plain.*' -exec cp {} app.jar \;
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]