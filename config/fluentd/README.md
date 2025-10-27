# Configuration Fluentd - Mode Asynchrone

## Vue d'ensemble

Cette configuration Fluentd est optimisée pour le **mode asynchrone** afin d'offrir les meilleures performances de collecte de logs.

## Architecture

```
Docker Container Logs
        ↓
   Fluentd (Port 24224)
        ↓
  [Buffer Asynchrone]
        ↓
   Elasticsearch
        ↓
     Kibana
```

## Caractéristiques du mode asynchrone

### Buffer Configuration

```ruby
<buffer>
  @type file
  path /fluentd/log/buffer/docker
  flush_mode async              # MODE ASYNCHRONE
  flush_thread_count 4          # 4 threads de flush en parallèle
  flush_interval 5s             # Flush toutes les 5 secondes
  flush_at_shutdown true        # Flush lors de l'arrêt
  retry_type exponential_backoff
  retry_wait 1s
  retry_max_interval 60s
  retry_timeout 1h
  overflow_action block
  chunk_limit_size 5M           # Taille max par chunk : 5MB
  queue_limit_length 32         # Max 32 chunks en queue
  compress gzip                 # Compression gzip
</buffer>
```

### Avantages du mode async

1. **Latence minimale** : Les logs sont immédiatement acceptés sans attendre l'écriture dans Elasticsearch
2. **Haute disponibilité** : Continue de fonctionner même si Elasticsearch est temporairement indisponible
3. **Throughput élevé** : Plusieurs threads de flush en parallèle (4 threads pour logs Docker)
4. **Pas de blocage** : Les applications ne sont jamais bloquées lors de l'envoi de logs

### Mécanisme de retry

- **Type** : Exponentiel backoff
- **Délai initial** : 1 seconde
- **Délai maximum** : 60 secondes
- **Timeout total** : 1 heure
- **Action en cas de débordement** : Block (empêche la perte de logs)

## Sources de logs

### 1. Forward Input (Port 24224)

Reçoit les logs des conteneurs Docker configurés avec le driver `fluentd`.

```yaml
logging:
  driver: fluentd
  options:
    fluentd-address: localhost:24224
    fluentd-async: "true"  # Client aussi en async
    tag: docker.drupal
```

### 2. Monitor Agent (Port 24220)

Expose les métriques internes de Fluentd pour le monitoring.

## Filtres appliqués

### Parser JSON

Tente de parser les logs au format JSON si applicable.

### Record Transformer

Ajoute des métadonnées :
- `hostname` : Nom de l'hôte
- `tag` : Tag du log
- `time` : Timestamp

## Sorties (Outputs)

### 1. Logs Docker → Elasticsearch

- **Index** : `drupal-logs-YYYY.MM.DD`
- **Format** : Logstash
- **Buffer** : 4 threads, flush toutes les 5s

### 2. Logs Système → Elasticsearch

- **Index** : `drupal-system-logs-YYYY.MM.DD`
- **Format** : Logstash
- **Buffer** : 2 threads, flush toutes les 10s

### Secondary Output (Backup)

En cas d'échec d'écriture dans Elasticsearch, les logs sont sauvegardés dans :
```
/fluentd/log/failed_records
```

## Monitoring

### Vérifier le statut de Fluentd

```bash
# Logs en temps réel
docker compose logs -f fluentd

# Vérifier les métriques
curl http://localhost:24220/api/plugins.json
```

### Vérifier les buffers

```bash
# Voir l'état des fichiers buffer
docker compose exec fluentd ls -lh /fluentd/log/buffer/
```

### Vérifier Elasticsearch

```bash
# Lister les indices
curl http://localhost:9200/_cat/indices?v

# Compter les documents dans un index
curl http://localhost:9200/drupal-logs-*/_count
```

## Performance

### Capacité théorique

- **Throughput** : ~10,000 logs/sec par thread
- **Total** : ~40,000 logs/sec (4 threads pour logs Docker)
- **Latency** : < 10ms pour accepter un log

### Dimensionnement du buffer

- **Chunk size** : 5 MB
- **Queue length** : 32 chunks
- **Capacité totale** : 160 MB en mémoire buffer
- **Compression** : gzip (~70% de réduction)

## Dépannage

### Logs ne sont pas visibles dans Kibana

1. Vérifier que Fluentd est démarré :
   ```bash
   docker compose ps fluentd
   ```

2. Vérifier les logs Fluentd :
   ```bash
   docker compose logs fluentd | grep ERROR
   ```

3. Vérifier la connectivité Elasticsearch :
   ```bash
   docker compose exec fluentd curl http://elasticsearch:9200
   ```

### Buffer plein

Si le buffer est plein (`overflow_action block`), vérifier :

1. Elasticsearch est accessible
2. Les index patterns sont corrects
3. Pas d'erreurs de mapping dans Elasticsearch

```bash
curl http://localhost:9200/_cat/indices?v
```

### Logs perdus

Vérifier le secondary output :
```bash
docker compose exec fluentd ls -lh /fluentd/log/failed_records/
```

## Configuration Docker

### Installation du plugin Elasticsearch

Le plugin est installé automatiquement au démarrage :

```dockerfile
command: >
  sh -c "gem install fluent-plugin-elasticsearch --no-document &&
         fluentd -c /fluentd/etc/fluent.conf"
```

### Volumes montés

- `./config/fluentd/fluent.conf` → `/fluentd/etc/fluent.conf` (config)
- `./data/fluentd/log` → `/fluentd/log` (buffers et logs)

## Références

- [Fluentd Buffer Plugin](https://docs.fluentd.org/buffer)
- [Elasticsearch Output Plugin](https://github.com/uken/fluent-plugin-elasticsearch)
- [Docker Logging Driver](https://docs.docker.com/config/containers/logging/fluentd/)
