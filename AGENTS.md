# Site du Club d'Athlétisme Guilérien (CAG)

Ce document fournit un aperçu structuré du projet pour aider les agents IA à comprendre le contexte, l'architecture et les flux de travail.

## 📋 Présentation du projet
Le projet est le site web officiel du **Club d'Athlétisme Guilérien (CAG)**, situé à Guilers (29).
Il sert de vitrine pour les activités du club (Athlétisme, Marche Nordique, Running), diffuse les horaires, les tarifs et permet le téléchargement des bulletins d'inscription.

**URL de production :** [https://www.guilersathle.fr/](https://www.guilersathle.fr/)

## 🛠 Pile technologique
- **Frontend :** HTML5, CSS3 (Bootstrap 5.3.8)
- **Logique :** TypeScript (compilé en JavaScript ES modules)
- **Composants :** 
  - `secure-link` : Web Component personnalisé pour l'obfuscation de liens (téléphones, emails) via Base64.
- **Outils de développement :**
  - TypeScript pour le typage.
  - ESLint, Stylelint, HTMLHint pour la qualité de code.
  - Python (`serve_www.py`) pour le serveur de développement local.

## 📂 Structure du répertoire
- `www/` : Racine du serveur web (fichiers statiques servis).
  - `index.html` : Page principale unique.
  - `custom.css` : Styles spécifiques au club.
  - `assets/` : Images, logos, fontes, ...
  - `ext/` : Documents PDF (bulletins d'inscription, règlements).
  - `fonts/` : Polices de caractères personnalisées.
- `src/` : Code source TypeScript.
  - `secure-link.ts` : Source du Web Component d'obfuscation.
- `package.json` : Dépendances et scripts de build/lint.
- `serve_www.py` : Script Python simple pour tester le site localement.
- `upload.sh` : Script pour le déploiement de l'application

## ⚙️ Flux de travail (Workflows)

### Développement
1. Lancer le serveur de test : `npm run serve` (ou `python3 serve_www.py`).
2. Compiler le TypeScript : `npm run build` (génère `www/secure-link.js`).
3. Mode "watch" pour TS : `npm run watch`.

### Déploiement
1. Le déploiement commence toujours pas un déploiement en "preview" : `upload.sh`
2. L'utilisateur doit vérifier à l'URL de production dans le dossier `/preview`

### Qualité
- Linter tout le projet : `npm run lint`.
- Linters spécifiques : `npm run lint:html`, `npm run lint:css`, `npm run lint:ts`.

## 💡 Notes importantes
- **Obfuscation :** Les numéros de téléphone et emails dans `index.html` sont encodés en Base64 dans l'attribut `data-url` du composant `<secure-link>`.
- **Typographie :** La classe CSS `.cag-font` utilise la police "Freshman" pour l'identité visuelle du club.
- **Structure HTML :** Le site utilise des sections sémantiques avec des IDs (ex: `#athletisme-detail`) pour la navigation interne via ancres.
