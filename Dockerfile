FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -pl BolnicaWeb -am -DskipTests --no-transfer-progress

FROM tomcat:11-jdk21-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/BolnicaWeb/target/*.war /usr/local/tomcat/webapps/Bolnica.war
EXPOSE 8080
CMD ["catalina.sh", "run"]