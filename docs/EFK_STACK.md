# Pile EFK - Elasticsearch, Fluentd, Kibana

## Vue d'ensemble

Ce projet intègre une pile complète de gestion et visualisation des logs basée sur:

- **Elasticsearch**: Base de données de recherche et d'analyse pour stocker les logs
- **Fluentd**: Collecteur unifié de logs qui agrège les données depuis Drupal et PostgreSQL
- **Kibana**: Interface de visualisation et d'analyse des logs

## Architecture

```
┌─────────────┐      ┌──────────────┐
│   Drupal    │─────▶│              │
└─────────────┘      │   Fluentd    │      ┌─────────────────┐
                     │   (24224)    │─────▶│ Elasticsearch   │
┌─────────────┐      │              │      │    (9200)       │
│  PostgreSQL │─────▶│              │      └────────┬────────┘
└─────────────┘      └──────────────┘               │
                                                     │
                                              ┌──────▼──────┐
                                              │   Kibana    │
                                              │   (5601)    │
                                              └─────────────┘
```

## Configuration des services

### Elasticsearch

- **Image**: `docker.elastic.co/elasticsearch/elasticsearch:8.11.1`
- **Port**: 9200 (HTTP API), 9300 (Transport)
- **Mémoire**: 512MB (Xms et Xmx)
- **Mode**: Single-node (pour développement)
- **Sécurité**: Désactivée (pour développement local uniquement)
- **Volume**: `./data/elasticsearch` - Données persistantes

**Healthcheck**: Vérifie l'état du cluster toutes les 30 secondes

### Fluentd

- **Image**: Custom build basé sur `fluent/fluentd:v1.16-1`
- **Port**: 24224 (TCP/UDP)
- **Configuration**: `./config/fluentd/fluent.conf`
- **Logs**: `./data/fluentd` - Buffer et logs

**Plugins installés**:
- `fluent-plugin-elasticsearch` - Pour envoyer les logs vers Elasticsearch

**Configuration**:
- Collecte les logs via le protocole Forward
- Parse les logs Drupal et PostgreSQL avec des expressions régulières
- Ajoute des métadonnées (hostname, environment, project)
- Envoie vers Elasticsearch avec format Logstash
- Buffer sur disque pour garantir la livraison

### Kibana

- **Image**: `docker.elastic.co/kibana/kibana:8.11.1`
- **Port**: 5601 (configurable via `KIBANA_PORT` dans `.env`)
- **Elasticsearch**: Connexion à `http://elasticsearch:9200`

## Démarrage

### Première utilisation

```bash
# 1. Démarrer tous les services
docker compose up -d

# 2. Vérifier que tous les services sont démarrés
docker compose ps

# 3. Attendre que Elasticsearch soit prêt (30-60 secondes)
docker compose logs -f elasticsearch

# 4. Vérifier que Fluentd est connecté
docker compose logs -f fluentd

# 5. Accéder à Kibana
# Ouvrir http://localhost:5601 dans votre navigateur
```

### Ordre de démarrage

L'ordre de démarrage est géré automatiquement par Docker Compose:

1. **Elasticsearch** démarre en premier
2. **Fluentd** attend qu'Elasticsearch soit healthy
3. **PostgreSQL** attend que Fluentd soit démarré
4. **Drupal** attend que PostgreSQL et Fluentd soient prêts
5. **Kibana** attend qu'Elasticsearch soit healthy

## Utilisation de Kibana

### Configuration initiale

1. **Accéder à Kibana**: http://localhost:5601

2. **Créer un index pattern**:
   - Menu hamburger → Management → Stack Management
   - Data → Index Patterns
   - Click "Create index pattern"
   - Pattern: `drupal-mania-*`
   - Next step
   - Time field: `@timestamp`
   - Create index pattern

3. **Visualiser les logs**:
   - Menu hamburger → Analytics → Discover
   - Sélectionner l'index pattern `drupal-mania-*`
   - Les logs apparaissent avec toutes leurs métadonnées

### Filtrage des logs

Dans Kibana Discover, vous pouvez filtrer par:

- **Service**: `@log_name:drupal` ou `@log_name:postgres`
- **Niveau de log**: `level:error`, `level:warning`, etc.
- **Message**: Recherche en texte libre dans le champ `message`
- **Période**: Sélecteur de temps en haut à droite

### Exemples de requêtes KQL

```
# Tous les logs d'erreur
level:error

# Logs Drupal uniquement
@log_name:drupal

# Logs PostgreSQL avec erreurs
@log_name:postgres AND level:error

# Recherche dans les messages
message:"database connection"
```

## Structure des logs

### Format Drupal

```json
{
  "@timestamp": "2025-10-27T10:30:45.123Z",
  "@log_name": "drupal",
  "level": "error",
  "message": "Database connection failed",
  "hostname": "drupal-app",
  "environment": "production",
  "project": "drupal-mania",
  "container_id": "abc123...",
  "container_name": "drupal-app"
}
```

### Format PostgreSQL

```json
{
  "@timestamp": "2025-10-27T10:30:45.123Z",
  "@log_name": "postgres",
  "level": "LOG",
  "process_id": "123",
  "message": "database system is ready to accept connections",
  "hostname": "drupal-postgres",
  "environment": "production",
  "project": "drupal-mania",
  "container_id": "def456...",
  "container_name": "drupal-postgres"
}
```

## Personnalisation

### Modifier la configuration Fluentd

Éditez `./config/fluentd/fluent.conf`:

```ruby
# Exemple: Ajouter un filtre personnalisé
<filter drupal>
  @type grep
  <exclude>
    key message
    pattern /debug/
  </exclude>
</filter>
```

Puis redémarrez Fluentd:

```bash
docker compose restart fluentd
```

### Ajuster les ressources Elasticsearch

Modifiez `docker-compose.yml`:

```yaml
elasticsearch:
  environment:
    - "ES_JAVA_OPTS=-Xms1g -Xmx1g"  # Augmenter à 1GB
```

### Ajouter des variables d'environnement

Créez un fichier `.env` à la racine:

```env
# Ports
DRUPAL_PORT=8080
KIBANA_PORT=5601

# PostgreSQL
POSTGRES_DB=drupal
POSTGRES_USER=drupal
POSTGRES_PASSWORD=drupal

# Environnement pour les logs
ENVIRONMENT=development
```

## Maintenance

### Visualiser les logs en temps réel

```bash
# Logs de tous les services
docker compose logs -f

# Logs Elasticsearch
docker compose logs -f elasticsearch

# Logs Fluentd
docker compose logs -f fluentd

# Logs Kibana
docker compose logs -f kibana
```

### Vérifier l'état d'Elasticsearch

```bash
# Health check
curl http://localhost:9200/_cluster/health?pretty

# Liste des indices
curl http://localhost:9200/_cat/indices?v

# Statistiques
curl http://localhost:9200/_stats?pretty
```

### Nettoyer les anciens logs

```bash
# Supprimer les indices de plus de 30 jours
curl -X DELETE "http://localhost:9200/drupal-mania-$(date -d '30 days ago' +%Y.%m.%d)"

# Ou via Kibana: Management → Stack Management → Index Management
```

### Réinitialiser complètement

```bash
# Arrêter tous les services
docker compose down

# Supprimer les données Elasticsearch
sudo rm -rf ./data/elasticsearch/*

# Supprimer les buffers Fluentd
sudo rm -rf ./data/fluentd/*

# Redémarrer
docker compose up -d
```

## Dépannage

### Elasticsearch ne démarre pas

```bash
# Vérifier les logs
docker compose logs elasticsearch

# Problème commun: permissions sur le volume
sudo chown -R 1000:1000 ./data/elasticsearch
```

### Fluentd ne reçoit pas de logs

```bash
# Vérifier que Fluentd écoute bien
docker compose exec fluentd netstat -ln | grep 24224

# Vérifier la configuration
docker compose exec fluentd cat /fluentd/etc/fluent.conf

# Tester la connexion
echo '{"message":"test"}' | docker run --rm -i fluent/fluentd:v1.16-1 \
  /usr/bin/fluent-cat test --host host.docker.internal --port 24224
```

### Kibana ne se connecte pas à Elasticsearch

```bash
# Vérifier la connectivité
docker compose exec kibana curl http://elasticsearch:9200

# Redémarrer Kibana
docker compose restart kibana
```

### Les logs n'apparaissent pas dans Kibana

1. Vérifier qu'il y a des indices:
   ```bash
   curl http://localhost:9200/_cat/indices?v
   ```

2. Vérifier que l'index pattern est correct dans Kibana

3. Vérifier la période de temps sélectionnée dans Kibana

4. Forcer un refresh:
   ```bash
   curl -X POST "http://localhost:9200/drupal-mania-*/_refresh"
   ```

## Sécurité (Production)

⚠️ **IMPORTANT**: La configuration actuelle est pour le développement local uniquement.

Pour la production:

1. **Activer la sécurité Elasticsearch**:
   ```yaml
   environment:
     - xpack.security.enabled=true
     - ELASTIC_PASSWORD=changeme
   ```

2. **Utiliser HTTPS**:
   - Configurer des certificats SSL/TLS
   - Activer `xpack.security.http.ssl.enabled=true`

3. **Authentification Kibana**:
   - Configurer `ELASTICSEARCH_USERNAME` et `ELASTICSEARCH_PASSWORD`

4. **Réseau**:
   - Ne pas exposer les ports 9200 et 9300 publiquement
   - Utiliser un reverse proxy (Nginx, Traefik)

5. **Firewall**:
   - Restreindre l'accès aux ports EFK

## Ressources

- [Elasticsearch Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)
- [Fluentd Documentation](https://docs.fluentd.org/)
- [Kibana Documentation](https://www.elastic.co/guide/en/kibana/current/index.html)
- [Docker Logging Drivers](https://docs.docker.com/config/containers/logging/fluentd/)

## Support

Pour toute question ou problème:
1. Consulter les logs: `docker compose logs -f`
2. Vérifier la documentation ci-dessus
3. Ouvrir une issue sur le repository GitHub
