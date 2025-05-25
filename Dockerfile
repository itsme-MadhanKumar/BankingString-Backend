# -------- Build Stage --------
FROM maven:3.9.8-eclipse-temurin-21 AS build
WORKDIR /appl
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# -------- Runtime Stage --------
FROM eclipse-temurin:21-jdk-slim
WORKDIR /app
COPY --from=build /appl/target/splitify-backend-0.0.1.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
