#########################
# 1️⃣ BUILD STAGE
#########################
FROM maven:3.9-eclipse-temurin-17-alpine AS build 
WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn -B clean package -DskipTests


#########################
# 2️⃣ RUNTIME STAGE
#########################
FROM tomcat:9.0.65-jdk17-temurin-jammy
RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
