# drupal-mania

Pile applicative Drupal complète avec PostgreSQL, Elasticsearch (EFK stack) et logging centralisé, déployée dans des conteneurs Docker.

## Description

Environnement de développement Drupal moderne avec :
- **Drupal 10** : CMS avec modules et thèmes personnalisés
- **PostgreSQL 15** : Base de données relationnelle
- **Pile EFK** : Elasticsearch, Fluentd, Kibana pour le logging centralisé
- **Mode asynchrone** : Logging non-bloquant avec buffers et retry automatique

Ce projet est géré avec historisation Git pour permettre l'itération continue avec Claude.

## Type de projet

**Type:** code

## Repository

```
https://github.com/aboigues/drupal-mania.git
```

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Navigateur Web                          │
└────────────┬────────────────────────────────────────────────┘
             │
             ├─────────────► http://localhost:8080  (Drupal)
             └─────────────► http://localhost:5601  (Kibana)
                                      │
┌────────────▼────────────┐          │
│       Drupal 10         │          │
│   + Modules/Thèmes      │──logs──► │
└────────────┬────────────┘          │
             │                        │
             ├──sql──► PostgreSQL    │
             │                        │
             └──logs──► Fluentd ◄────┘
                           │
                           ├──► Elasticsearch
                           │         │
                           └─────────┴──► Kibana
```

## Structure

```
drupal-mania/
├── README.md                  # Ce fichier
├── docker-compose.yml         # Configuration Docker Compose
├── .env.example               # Exemple de configuration
├── .claude/                   # Configuration et instructions pour Claude
│   ├── INSTRUCTIONS.md        # Instructions complètes pour Claude
│   ├── QUICKSTART.md          # Démarrage rapide (EFK inclus)
│   └── CONTEXT.md             # Contexte et historique du projet
├── config/                    # Configurations des services
│   └── fluentd/
│       └── fluent.conf        # Configuration Fluentd (mode async)
├── templates/                 # Templates Drupal versionnés
│   └── drupal/
│       ├── modules/           # Modules personnalisés
│       └── themes/            # Thèmes personnalisés
├── data/                      # Données persistantes (non versionnées)
│   ├── postgres/              # Données PostgreSQL
│   ├── drupal/                # Données Drupal
│   ├── elasticsearch/         # Index et données Elasticsearch
│   └── fluentd/               # Buffers et logs Fluentd
├── docs/                      # Documentation
└── tests/                     # Tests
```

## Prérequis

- Docker Engine 20.10+
- Docker Compose 2.0+
- 4 GB RAM minimum (8 GB recommandé pour Elasticsearch)
- 10 GB d'espace disque

## Services disponibles

Une fois démarrés, les services sont accessibles aux URLs suivantes:

| Service | URL | Description |
|---------|-----|-------------|
| **Drupal** | http://localhost:8080 | Interface CMS Drupal |
| **Kibana** | http://localhost:5601 | Interface de visualisation des logs |
| **Elasticsearch** | http://localhost:9200 | API REST (interne) |
| **PostgreSQL** | localhost:5432 | Base de données (interne) |
| **Fluentd** | localhost:24224 | Collecteur de logs (interne) |
| **Fluentd Monitor** | http://localhost:24220 | API de monitoring Fluentd |

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

**Base de données:**
- `POSTGRES_DB`: Nom de la base de données (défaut: drupal)
- `POSTGRES_USER`: Utilisateur PostgreSQL (défaut: drupal)
- `POSTGRES_PASSWORD`: Mot de passe PostgreSQL (défaut: drupal_secure_password_change_me)

**Ports:**
- `DRUPAL_PORT`: Port d'accès à Drupal (défaut: 8080)
- `KIBANA_PORT`: Port d'accès à Kibana (défaut: 5601)

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

### 6. Accéder à Kibana (Logging centralisé)

Ouvrir un navigateur et aller à: `http://localhost:5601`

**Configuration initiale de Kibana:**

1. **Créer un index pattern** pour visualiser les logs:
   - Menu → Stack Management → Index Patterns
   - Cliquez sur "Create index pattern"
   - Pattern: `drupal-logs-*` (pour les logs applicatifs)
   - Sélectionnez `@timestamp` comme champ temporel
   - Cliquez sur "Create"

2. **Visualiser les logs**:
   - Menu → Discover
   - Sélectionnez l'index pattern `drupal-logs-*`
   - Définissez la période: Last 15 minutes
   - Les logs Drupal apparaîtront en temps réel

**Logs système Fluentd** (optionnel):
- Créez également un pattern `drupal-system-logs-*`
- Utilisez-le pour voir les logs de Fluentd lui-même

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

# Fluentd uniquement
docker-compose logs -f fluentd

# Elasticsearch uniquement
docker-compose logs -f elasticsearch
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

### Pile EFK (Elasticsearch, Fluentd, Kibana)

```bash
# Vérifier le statut de tous les services
docker-compose ps

# Vérifier la santé d'Elasticsearch
curl http://localhost:9200/_cluster/health?pretty

# Lister les index Elasticsearch
curl http://localhost:9200/_cat/indices?v

# Rechercher les derniers logs
curl "http://localhost:9200/drupal-logs-*/_search?pretty&size=10&sort=@timestamp:desc"

# Voir les stats des buffers Fluentd
curl http://localhost:24220/api/plugins.json

# Accéder à Kibana
# http://localhost:5601
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

### Pile EFK (Logging centralisé)

**Architecture de logging moderne:**

```
Services Docker → Fluentd (async) → Elasticsearch → Kibana
```

**Caractéristiques:**

- **Mode asynchrone** : Logging non-bloquant avec 4 threads de flush
- **Buffers persistants** : 32 chunks pour Docker, 16 pour le système
- **Compression gzip** : Réduction de l'espace disque
- **Retry exponentiel** : Gestion robuste des pannes (1h max)
- **Logs de secours** : Sauvegarde en cas d'échec définitif
- **Monitoring** : API sur le port 24220

**Services et ports:**

- **Elasticsearch** : Port 9200 (interne uniquement)
- **Kibana** : http://localhost:5601
- **Fluentd** : Port 24224 (TCP/UDP)

**Index créés automatiquement:**

- `drupal-logs-*` : Logs applicatifs (Drupal, services Docker)
- `drupal-system-logs-*` : Logs système (Fluentd)

Voir [.claude/QUICKSTART.md](.claude/QUICKSTART.md) section EFK pour plus de détails.

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

### Elasticsearch ne démarre pas

```bash
# Vérifier les logs
docker-compose logs elasticsearch

# Augmenter la mémoire virtuelle (Linux)
sudo sysctl -w vm.max_map_count=262144

# Rendre permanent (Linux)
echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf
```

### Les logs n'apparaissent pas dans Kibana

```bash
# Vérifier que Fluentd fonctionne
docker-compose logs fluentd

# Vérifier qu'Elasticsearch reçoit des données
curl http://localhost:9200/_cat/indices?v

# Vérifier les buffers Fluentd
curl http://localhost:24220/api/plugins.json

# Redémarrer Fluentd
docker-compose restart fluentd
```

### Kibana ne se connecte pas à Elasticsearch

```bash
# Vérifier la santé d'Elasticsearch
curl http://localhost:9200/_cluster/health?pretty

# Attendre que le statut soit au moins "yellow"
# Redémarrer Kibana
docker-compose restart kibana
```

### Les buffers Fluentd sont pleins

```bash
# Vérifier l'espace disque
df -h

# Nettoyer les anciens buffers (attention: perte de données)
docker-compose stop fluentd
rm -rf data/fluentd/log/buffer/*
docker-compose start fluentd

# Ou augmenter queue_limit_length dans config/fluentd/fluent.conf
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
