# Stage 1: Build
FROM eclipse-temurin:20-jdk-alpine AS build
WORKDIR /app

## Copier les fichiers de configuration Gradle UNIQUEMENT
## Cette couche sera cachée tant que ces fichiers ne changent pas
COPY gradlew build.gradle settings.gradle ./
COPY gradle.properties* ./
COPY gradle ./gradle

## Rendre gradlew exécutable
RUN chmod +x gradlew

## Pré-télécharger les dépendances Gradle (couche cachée)
RUN ./gradlew dependencies --no-daemon || true

## Copier le code source
COPY src ./src

## Build de l'application (sans les tests pour gagner du temps)
RUN ./gradlew clean build -x test --no-daemon

# Stage 2: Runtime
FROM eclipse-temurin:20-jre-alpine
WORKDIR /app

## Créer un utilisateur non-root pour la sécurité
RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup

## Copier le JAR/WAR depuis le stage de build
COPY --from=build /app/build/libs/*.war app.war

## Changer les permissions
RUN chown appuser:appgroup app.war

## Passer à l'utilisateur non-root
USER appuser

## Exposer le port
EXPOSE 8080

## Lancer l'application avec optimisations JVM
ENTRYPOINT ["java", \
    "-Djava.security.egd=file:/dev/./urandom", \
    "-XX:+UseContainerSupport", \
    "-XX:MaxRAMPercentage=75.0", \
    "-jar", \
    "app.war"]