#!/bin/bash
set -e

BACK_DIR="./back"
FRONT_DIR="./front"
RESULTS_DIR="/test-results"
BACK_RESULTS_DIR="./back$RESULTS_DIR"
FRONT_RESULTS_DIR="./front$RESULTS_DIR"

# Nettoyer anciens rapports
rm -rf "$BACK_RESULTS_DIR" "$FRONT_RESULTS_DIR"
mkdir -p "$BACK_RESULTS_DIR" "$FRONT_RESULTS_DIR"

echo "=== Running tests for all projects ==="

# -------------------------------
# Back-end tests (Java / Gradle)
# -------------------------------
if [ -f "$BACK_DIR/gradlew" ]; then
    echo "🔹 Running back-end tests in $BACK_DIR"
    cd "$BACK_DIR" || { echo "Cannot cd to $BACK_DIR"; exit 1; }

    [ ! -x "./gradlew" ] && chmod +x ./gradlew

    # Nettoyer les anciens artefacts Gradle
    ./gradlew clean

    # Lancer les tests
    ./gradlew test -x javadoc --no-daemon

    cd - >/dev/null
else
    echo "[WARN] No Gradle wrapper found in $BACK_DIR, skipping back-end tests."
fi

# -------------------------------
# Front-end
# -------------------------------
if [ -f "$FRONT_DIR/package.json" ]; then
    echo "🔹 Running front-end tests in $FRONT_DIR"
    cd "$FRONT_DIR"

    command -v npm >/dev/null 2>&1 || { echo "[ERROR] npm not found"; exit 1; }

    # Installer les dépendances
    npm install

    # Nettoyer les anciens rapports Karma
    rm -rf ./karma-results
    mkdir -p ./karma-results

    # Lancer les tests avec Karma et générer les rapports JUnit XML
    npm run test -- --watch=false --browsers=ChromeHeadless

    # Copier les rapports dans test-results
    if [ -d karma-results ]; then
        cp -r karma-results/*.xml "$FRONT_RESULTS_DIR" || true
    fi

    cd - >/dev/null
else
    echo "[WARN] No package.json found in $FRONT_DIR, skipping front-end tests."
fi

echo "[SUCCESS] All tests completed. Reports available in $BACK_RESULTS_DIR and $FRONT_RESULTS_DIR"