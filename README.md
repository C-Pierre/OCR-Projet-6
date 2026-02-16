# README.md


## Initialisation du projet
Une fois le dépôt Github récupéré, se placer à la racine du projet dans`./ back` et dans `./front` et exécuter la commande suivante :
-       docker compose up -d --build

## Exercices

### Exercice 1
- Front :
    - Mise en place d'un `docker-compose.yml` et d'un `Dockerfile` pour la conteneurisation du front-end
- Back :
    - Mise en place d'un `docker-compose.yml` et d'un `Dockerfile` pour la conteneurisation du back-end
    - Un script `./back/db/docker-entrypoint-init.sh` a été mit en place pour executer les deux autres scripts présents dans le répertoire au moment du démarrage

### Exercice 2
- Commun :
    - Mise en place d'un script `./run-tests.sh` pour l'exécution des tests unifié
    - Les rapports de tests se trouvents dans les dossiers `test-results` dans `./back` et `./front`
    - Les rapports de tests sont également créés au moment de la CI et disponible dans les informations de la MR.

### Corrections
- CI :
    - Le stage de tests avait été supprimé par erreur.
    - Cash : optimisation de la mise en cache des éléments, comme les paquets npm ou le package.json