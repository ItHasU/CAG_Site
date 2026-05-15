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
    upload.sh --force # Réalise le déploiement
    ```
* L'agent ne doit jamais faire lui même le déploiement réel sans y être explicitement invité

## ⚠️ Key Architectural Notes
* Le projet un site statique écrit directement en HTML, il n'y a donc pas de phase de compilation.
* Les fichiers sont disponibles dans le dossier www/
* Le dossier src/ contient des documents source (images, ...) utilisés pour générer du contenu dans la page.
