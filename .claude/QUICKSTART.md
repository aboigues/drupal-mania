# QUICKSTART - Claude - drupal-mania

## Début de session

```bash
# 1. Retrouver contexte
conversation_search: "drupal-mania"

# 2. Cloner
cd /home/claude
git clone https://TOKEN@github.com/aboigues/drupal-mania.git
cd drupal-mania

# 3. Lire instructions
cat .claude/INSTRUCTIONS.md

# 4. Lire contexte
cat .claude/CONTEXT.md
```

## Workflow standard

```bash
# Modifier selon demande
# ...

# Mettre à jour contexte
echo "## Session $(date +%Y-%m-%d)" >> .claude/CONTEXT.md
echo "- [Changements]" >> .claude/CONTEXT.md

# Push
git add .
git commit -m "Session $(date +%Y-%m-%d): Description"
git push origin main

# Outputs
cp -r . /mnt/user-data/outputs/drupal-mania/
```

## Règles essentielles

- Toujours partir de la dernière version Git
- Mettre à jour CONTEXT.md
- Messages de commit clairs
- Documenter les changements importants

## Pile EFK (Elasticsearch, Fluentd, Kibana)

### Architecture de logging

La pile de logging collecte et visualise les logs de tous les services :

```
Services Docker → Fluentd (async) → Elasticsearch → Kibana
```

### Fluentd - Configuration asynchrone

Fluentd est configuré en **mode asynchrone** pour des performances optimales :

- **Buffers asynchrones** : `flush_mode async` avec 4 threads de flush
- **Compression gzip** : Réduction de l'utilisation disque
- **Retry exponentiel** : Gestion robuste des pannes
- **Queue** : 32 chunks pour les logs Docker, 16 pour les logs système

Configuration : `config/fluentd/fluent.conf`

### Services et ports

- **Elasticsearch** : http://localhost:9200 (interne)
- **Kibana** : http://localhost:5601
- **Fluentd** : Port 24224 (TCP/UDP)

### Utilisation

```bash
# Démarrer la pile complète
docker compose up -d

# Vérifier les logs Fluentd
docker compose logs -f fluentd

# Accéder à Kibana
# Naviguer vers http://localhost:5601
# Créer un index pattern : drupal-logs-*

# Vérifier Elasticsearch
curl http://localhost:9200/_cat/indices?v

# Voir les logs en temps réel dans Kibana
# Discover → drupal-logs-* → Time range: Last 15 minutes
```

### Configuration des index Kibana

1. Accéder à Kibana : http://localhost:5601
2. Menu → Stack Management → Index Patterns
3. Créer un pattern :
   - **drupal-logs-*** pour les logs applicatifs
   - **drupal-system-logs-*** pour les logs système
4. Sélectionner @timestamp comme champ temporel
5. Discover → Visualiser les logs

### Performances

Fluentd en mode async offre :
- Latence minimale pour les applications
- Throughput élevé (plusieurs milliers de logs/sec)
- Pas de blocage en cas de pic de logs
- Gestion gracieuse des pannes d'Elasticsearch

## Repository

https://github.com/aboigues/drupal-mania.git
