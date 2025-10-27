# drupal-mania

Pile applicative Drupal + postgres déployée dans des conteneurs Docker

## Description

Ce projet est géré avec historisation Git pour permettre l'itération continue avec Claude.

## Type de projet

**Type:** code

## Repository

```
https://github.com/aboigues/drupal-mania.git
```

## Structure

```
drupal-mania/
├── README.md                  # Ce fichier
├── docker-compose.yml         # Configuration Docker
├── .env.example               # Exemple de configuration
├── .claude/                   # Configuration et instructions pour Claude
│   ├── INSTRUCTIONS.md        # Instructions complètes pour Claude
│   ├── QUICKSTART.md          # Démarrage rapide
│   └── CONTEXT.md             # Contexte et historique du projet
├── templates/                 # Templates Drupal versionnés
│   └── drupal/
│       ├── modules/           # Modules personnalisés
│       └── themes/            # Thèmes personnalisés
├── data/                      # Données persistantes (non versionnées)
│   ├── postgres/              # Données PostgreSQL
│   └── drupal/                # Données Drupal
├── docs/                      # Documentation
└── tests/                     # Tests
```

## Prérequis

- Docker Engine 20.10+
- Docker Compose 2.0+

## Démarrage rapide

### 1. Cloner le repository

```bash
git clone https://github.com/aboigues/drupal-mania.git
cd drupal-mania
```

### 2. Configuration (optionnel)

Copier le fichier d'exemple de configuration:

```bash
cp .env.example .env
```

Modifier le fichier `.env` pour personnaliser:
- `POSTGRES_DB`: Nom de la base de données (défaut: drupal)
- `POSTGRES_USER`: Utilisateur PostgreSQL (défaut: drupal)
- `POSTGRES_PASSWORD`: Mot de passe PostgreSQL (défaut: drupal_secure_password_change_me)
- `DRUPAL_PORT`: Port d'accès à Drupal (défaut: 8080)

### 3. Démarrer les conteneurs

```bash
docker-compose up -d
```

### 4. Accéder à Drupal

Ouvrir un navigateur et aller à: `http://localhost:8080`

L'assistant d'installation de Drupal s'ouvrira. Utiliser les paramètres suivants:

**Configuration de la base de données:**
- Type de base de données: PostgreSQL
- Nom de la base: drupal (ou valeur de POSTGRES_DB)
- Utilisateur: drupal (ou valeur de POSTGRES_USER)
- Mot de passe: drupal_secure_password_change_me (ou valeur de POSTGRES_PASSWORD)
- Hôte: postgres
- Port: 5432

### 5. Activer les modules et thèmes personnalisés

Le projet inclut des templates Drupal prêts à l'emploi:

**Module Drupal Mania:**
1. Allez dans **Extend** (Extensions)
2. Cherchez "Drupal Mania Module"
3. Cochez la case et cliquez sur "Install"
4. Accédez au dashboard: `http://localhost:8080/drupalmania/dashboard`

**Thème Drupal Mania:**
1. Allez dans **Appearance** (Apparence)
2. Cherchez "Drupal Mania Theme"
3. Cliquez sur "Install and set as default"

Pour plus d'informations, consultez [templates/README.md](templates/README.md)

## Commandes utiles

### Démarrer les services

```bash
docker-compose up -d
```

### Arrêter les services

```bash
docker-compose down
```

### Voir les logs

```bash
# Tous les services
docker-compose logs -f

# Drupal uniquement
docker-compose logs -f drupal

# PostgreSQL uniquement
docker-compose logs -f postgres
```

### Redémarrer les services

```bash
docker-compose restart
```

### Accéder au conteneur Drupal

```bash
docker exec -it drupal-app bash
```

### Accéder à PostgreSQL

```bash
docker exec -it drupal-postgres psql -U drupal -d drupal
```

### Vider le cache Drupal

```bash
# Méthode 1: Via Drush (recommandé)
docker exec -it drupal-app drush cr

# Méthode 2: Via l'interface admin
# Configuration > Development > Performance > Clear all caches
```

## Structure du projet

```
drupal-mania/
├── README.md                  # Ce fichier
├── docker-compose.yml         # Configuration Docker
├── .env.example               # Exemple de configuration
├── .claude/                   # Configuration et instructions pour Claude
│   ├── INSTRUCTIONS.md        # Instructions complètes pour Claude
│   ├── QUICKSTART.md          # Démarrage rapide
│   └── CONTEXT.md             # Contexte et historique du projet
├── templates/                 # Templates Drupal (versionnés)
│   ├── README.md              # Documentation des templates
│   └── drupal/
│       ├── modules/           # Modules personnalisés
│       │   └── drupalmania_module/  # Module principal
│       └── themes/            # Thèmes personnalisés
│           └── drupalmania_theme/   # Thème principal
├── docs/                      # Documentation
├── data/                      # Données persistantes (non versionnées)
│   ├── postgres/              # Données PostgreSQL
│   └── drupal/                # Données Drupal
│       ├── modules/           # Modules utilisateur
│       ├── themes/            # Thèmes utilisateur
│       ├── sites/             # Configuration du site
│       └── profiles/          # Profils d'installation
└── tests/                     # Tests
```

## Fonctionnalités incluses

### Templates Drupal personnalisés

Le projet inclut des templates prêts à l'emploi:

- **Module Drupal Mania** : Dashboard avec statistiques, pages personnalisées, configuration
- **Thème Drupal Mania** : Design responsive, templates Twig, CSS variables

Les templates sont versionnés dans Git et montés automatiquement dans les conteneurs.

Voir [templates/README.md](templates/README.md) pour plus de détails.

## Dépannage

### Les conteneurs ne démarrent pas

Vérifier que Docker est en cours d'exécution:
```bash
docker info
```

### Port 8080 déjà utilisé

Modifier la variable `DRUPAL_PORT` dans le fichier `.env`

### Le module/thème n'apparaît pas

```bash
# Vider le cache Drupal
docker exec -it drupal-app drush cr

# Redémarrer les conteneurs
docker-compose restart
```

### Réinitialiser complètement

```bash
docker-compose down -v
rm -rf data/postgres data/drupal
docker-compose up -d
```

## Workflow avec Claude

### Nouvelle session

1. Claude recherche le contexte avec `conversation_search`
2. Clone le repo
3. Lit `.claude/INSTRUCTIONS.md`
4. Itère sur le code existant
5. Commit et push les modifications

### Commandes Git

```bash
# Cloner
git clone https://TOKEN@github.com/aboigues/drupal-mania.git

# Voir l'historique
git log --oneline

# Pousser les modifications
git add .
git commit -m "Description"
git push origin main
```

## Auteur

**Utilisateur:** aboigues
**Créé avec:** Claude (Anthropic)
**Date:** 2025-10-27
