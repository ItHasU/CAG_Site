# AGENTS.md - CAG_Site Workflow Guide

## ⚙️ Setup and Running the Application

* **Dev Server:** To run a local HTTP server, use the dedicated Python script:
    ```bash
    python3 serve_www.py
    ```
    *Note:* Dans opencode, le serveur doit être lancé en arrière-plan (background) pour rester actif tout en permettant de saisir de nouvelles commandes :
    ```bash
    nohup python3 serve_www.py > server.log 2>&1 &
    ```
* **Déploiement:** Pour déployer le site, utiliser la commande suivante:
    ```bash
    upload.sh # Déploie dans le dossier preview/ afin de permettre une prévisualisation du futur site
    upload.sh --prod # Réalise le déploiement en production (destination root)
    ```

Comportement spécifique du script `upload.sh` lors du déploiement en production :
* Le script échoue s'il y a des modifications dans le dépôt git
* Le commit courant est taggué avec la date courante

## Déploiement de l'application

* Si l'utilisateur demande un déploiement, il faut toujours commencer par une preview
* Ensuite il faut la confirmation que la preview convient bien
* Puis seulement on peut passer le site en production
* ⚠️ L'agent ne doit jamais faire le déploiement en production sans avoir explicitement demandé à l'utilisateur

## ⚠️ Key Architectural Notes
* Le projet un site statique écrit directement en HTML, il n'y a donc pas de phase de compilation.
* Les fichiers sont disponibles dans le dossier www/
* Le dossier src/ contient des documents source (images, ...) utilisés pour générer du contenu dans la page.
