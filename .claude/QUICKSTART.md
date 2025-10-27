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

## Pile EFK (Elasticsearch, Fluentd, Kibana)

Le projet intègre une pile complète de gestion et visualisation des logs.

### Accès aux services

```bash
# Démarrer tous les services (incluant EFK)
docker compose up -d

# Vérifier l'état des services
docker compose ps

# Accès Kibana (visualisation des logs)
http://localhost:5601

# Accès Elasticsearch (API)
http://localhost:9200
```

### Utilisation de Kibana

1. Ouvrir http://localhost:5601
2. Aller dans "Management" > "Stack Management" > "Index Patterns"
3. Créer un index pattern: `drupal-mania-*`
4. Sélectionner `@timestamp` comme champ de temps
5. Aller dans "Discover" pour voir les logs

### Configuration

- **Elasticsearch**: Port 9200 (données stockées dans `./data/elasticsearch`)
- **Fluentd**: Port 24224 (config dans `./config/fluentd`)
- **Kibana**: Port 5601 (variable `KIBANA_PORT` dans `.env`)

Les logs de Drupal et PostgreSQL sont automatiquement collectés et indexés.

## Règles essentielles

- Toujours partir de la dernière version Git
- Mettre à jour CONTEXT.md
- Messages de commit clairs
- Documenter les changements importants

## Repository

https://github.com/aboigues/drupal-mania.git
