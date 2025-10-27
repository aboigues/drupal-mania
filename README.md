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
├── .claude/                   # Configuration et instructions pour Claude
│   ├── INSTRUCTIONS.md        # Instructions complètes pour Claude
│   ├── QUICKSTART.md          # Démarrage rapide
│   └── CONTEXT.md             # Contexte et historique du projet
├── docs/                      # Documentation
├── src/                       # Code source
├── data/                      # Données
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
├── docs/                      # Documentation
├── data/                      # Données persistantes
│   ├── postgres/              # Données PostgreSQL (non versionné)
│   └── drupal/                # Données Drupal (non versionné)
└── tests/                     # Tests
```

## Dépannage

### Les conteneurs ne démarrent pas

Vérifier que Docker est en cours d'exécution:
```bash
docker info
```

### Port 8080 déjà utilisé

Modifier la variable `DRUPAL_PORT` dans le fichier `.env`

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
