# First_step : Build
FROM eclipse-temurin:20-jdk-alpine AS build
WORKDIR /app

COPY gradlew build.gradle settings.gradle gradle.properties* ./
COPY gradle ./gradle
COPY . .

RUN ./gradlew --version

COPY . .
RUN ./gradlew clean build -x test --no-daemon

# First_step : Run
FROM eclipse-temurin:20-jre-alpine
WORKDIR /app

COPY --from=build /app/build/libs/*.war app.war

EXPOSE 8080
ENTRYPOINT ["java","-jar","app.war"]