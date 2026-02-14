# README.md


## Initialisation du projet
Une fois le dépôt Github récupéré, se placer à la racine du projet et exécuter la commande suivante :
-       docker compose up -d --build

Cette commande peut également être exécutée à la racine des dossiers ./back et ./front à fin de lancer individuellement les conteneurs.

## Exercices

### Exercice 1
- Front :
    - Mise en place d'un `docker-compose.yml` et d'un `Dockerfile` pour la conteneurisation du front-end
- Back :
    - Mise en place d'un `docker-compose.yml` et d'un `Dockerfile` pour la conteneurisation du back-end
    - Un script `./back/db/docker-entrypoint-init.sh` a été mit en place pour executer les deux autres scripts présents dans le répertoire au moment du démarrage
- Commun :
    - Mise en place d'un `docker-compose.yml` commun pour gérer les deux parties back-end et front-end

### Exercice 2
- Commun :
    - Mise en place d'un script `./run-tests.sh` pour l'exécution des tests unifié
    - Les rapports de tests se trouvents dans les dossiers `test-results` dans `./back` et `./front`

### Corrections
- CI :
    - Le stage de tests avait été supprimé par erreur.
    - Cash : optimisation de la mise en cache des éléments, comme les paquets npm ou le package.json