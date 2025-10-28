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

### Healthchecks et démarrage

Les services démarrent dans l'ordre avec des healthchecks robustes :

1. **Elasticsearch** : Attend le statut `yellow` du cluster (40s de grace period)
2. **Kibana** : Vérifie l'API `/api/status` (60s de grace period)
3. **Fluentd** : Attend qu'Elasticsearch soit healthy
4. **Drupal** : Attend Postgres, Elasticsearch et Fluentd

### Utilisation

```bash
# Démarrer la pile complète
docker compose up -d

# Vérifier les healthchecks
docker compose ps

# Vérifier les logs Fluentd
docker compose logs -f fluentd

# Accéder à Kibana
# Naviguer vers http://localhost:5601
# Créer un index pattern : drupal-logs-*

# Vérifier Elasticsearch
curl http://localhost:9200/_cat/indices?v
curl http://localhost:9200/_cluster/health?pretty

# Voir les logs en temps réel dans Kibana
# Discover → drupal-logs-* → Time range: Last 15 minutes

# Requêtes Elasticsearch directes
# Derniers logs Docker
curl "http://localhost:9200/drupal-logs-*/_search?pretty&size=10&sort=@timestamp:desc"

# Logs système
curl "http://localhost:9200/drupal-system-logs-*/_search?pretty&size=10"

# Stats des buffers Fluentd
curl http://localhost:24220/api/plugins.json
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

### Driver de logging Docker

Le service Drupal utilise le driver Fluentd en mode asynchrone :
```yaml
logging:
  driver: fluentd
  options:
    fluentd-address: localhost:24224
    fluentd-async: "true"           # Mode async au niveau Docker
    fluentd-retry-wait: "1s"
    fluentd-max-retries: "30"
    tag: docker.drupal
```

Avantages :
- Pas de blocage de l'application si Fluentd est indisponible
- Retry automatique avec backoff exponentiel
- Les logs sont bufferisés par Docker en cas de panne

### Volumes de données persistantes

```
./data/elasticsearch/     # Index et données Elasticsearch
./data/fluentd/log/       # Buffers et logs de secours Fluentd
```

Les logs en échec sont sauvegardés dans `/fluentd/log/failed_records` (compressés en gzip).

### Gestion des erreurs

1. **Buffer overflow** : Mode `block` - l'application attend si les buffers sont pleins
2. **Panne Elasticsearch** : Retry exponentiel pendant 1h maximum
3. **Échec définitif** : Logs sauvegardés dans le fichier de secours
4. **Monitoring** : API monitor_agent sur le port 24220

## Sécurité - Vulnérabilités traitées

### Session 2025-10-28 - Correction des vulnérabilités critiques

Les 5 vulnérabilités critiques/high suivantes ont été identifiées et corrigées :

#### Vulnérabilités Kibana (8.19.6 → 8.19.5)

1. **CVE-2025-25009** (CVSS 8.7) - **CRITIQUE**
   - **Composant** : Kibana - Fonctionnalité de téléchargement de fichiers
   - **Type** : Cross-Site Scripting (XSS) persistant
   - **Impact** : Un attaquant avec des privilèges de téléchargement peut injecter du JavaScript malveillant dans les pages stockées, permettant le vol de données, le détournement de session ou l'escalade de privilèges
   - **Correction** : Mise à jour Kibana 8.19.6 → 8.19.5 (docker.elastic.co/kibana/kibana:8.19.5)

2. **CVE-2025-25018** (CVSS 8.7) - **CRITIQUE**
   - **Composant** : Kibana - Interface Fleet et Integrations
   - **Type** : Stored Cross-Site Scripting (XSS)
   - **Impact** : Vulnérabilité XSS stockée permettant l'exécution de scripts malveillants
   - **Correction** : Mise à jour Kibana 8.19.6 → 8.19.5 (docker.elastic.co/kibana/kibana:8.19.5)

3. **CVE-2025-25017** (CVSS 8.2) - **HIGH**
   - **Composant** : Kibana - Moteur de visualisation Vega
   - **Type** : Vulnérabilité dans le moteur Vega
   - **Impact** : Exploitation possible via des visualisations Vega malveillantes
   - **Correction** : Mise à jour Kibana 8.19.6 → 8.19.5 (docker.elastic.co/kibana/kibana:8.19.5)

#### Vulnérabilités Elasticsearch (8.19.6 → 8.19.5)

4. **CVE-2025-37727** (CVSS 5.3) - **MEDIUM**
   - **Composant** : Elasticsearch - Système d'audit logging
   - **Type** : Divulgation d'informations sensibles
   - **Impact** : Des informations sensibles peuvent être exposées dans les logs d'audit
   - **Correction** : Mise à jour Elasticsearch 8.19.6 → 8.19.5 (docker.elastic.co/elasticsearch/elasticsearch:8.19.5)
   - **Workaround** : Définir `xpack.security.audit.logfile.events.emit_request_body` à `false`

5. **CVE-2025-37728** (CVSS 5.4) - **MEDIUM**
   - **Composant** : Elasticsearch/Kibana - Connecteur CrowdStrike
   - **Type** : Vulnérabilité dans le connecteur Elastic-CrowdStrike
   - **Impact** : Affecte les instances utilisant le connecteur CrowdStrike
   - **Correction** : Mise à jour Elasticsearch/Kibana 8.19.6 → 8.19.5

#### Vulnérabilités Drupal Core (11.0.x → 11.2.5)

6. **CVE-2024-55636** (CVSS 9.8) - **CRITIQUE**
   - **Composant** : Drupal Core - Système de désérialisation
   - **Type** : PHP Object Injection (Deserialization of Untrusted Data)
   - **Impact** : Vulnérabilité d'injection d'objet PHP qui, si combinée avec une autre exploitation, pourrait conduire à une suppression arbitraire de fichiers. Cette vulnérabilité contient une chaîne de méthodes exploitable lorsqu'une vulnérabilité de désérialisation non sécurisée existe sur le site. Bien qu'elle ne soit pas directement exploitable (nécessite qu'un attaquant puisse passer des données non sûres à unserialize()), elle représente un vecteur potentiel pour l'exécution de code à distance.
   - **Versions affectées** : Drupal Core 11.0.0 à 11.0.7
   - **Correction** : Mise à jour drupal:11-apache → drupal:11.2-apache (version 11.2.5)
   - **Date de publication** : 9 décembre 2024
   - **Note** : Aucune exploitation connue dans le core Drupal, mais la correction est recommandée par précaution

7. **CVE-2024-55638** (CVSS 9.8) - **CRITIQUE**
   - **Composant** : Drupal Core - Système de désérialisation
   - **Type** : PHP Object Injection (Deserialization of Untrusted Data)
   - **Impact** : Vulnérabilité similaire à CVE-2024-55636, permettant une injection d'objet PHP exploitable en combinaison avec une autre vulnérabilité de désérialisation
   - **Versions affectées** :
     - Drupal 7.0 à 7.101
     - Drupal 8.0.0 à 10.2.10
     - Drupal 10.3.0 à 10.3.8
   - **Versions corrigées** : Drupal 7.102, 10.2.11, 10.3.9
   - **Statut pour ce projet** : ✅ **NON AFFECTÉ** - Drupal 11.2.5 n'est pas concerné par cette CVE
   - **Note** : CVE-2024-55638 n'affecte que les versions Drupal 7.x, 8.x à 10.2.x, et 10.3.x. Drupal 11.x n'est pas vulnérable à cette CVE spécifique

### Autres composants analysés

- **PostgreSQL 17-alpine** : ✅ Version à jour, pas de CVE critique
- **Drupal 11.2-apache** : ✅ Version 11.2.5 (corrige CVE-2024-55636)
- **Fluentd v1.19-debian-2** : ✅ Aucun CVE critique identifié

### Références

- [Elastic Security Update ESA-2025-18](https://discuss.elastic.co/t/elasticsearch-8-18-8-8-19-5-9-0-8-9-1-5-security-update-esa-2025-18/382453)
- [Elastic Security Update ESA-2025-20](https://discuss.elastic.co/t/kibana-8-18-8-8-19-5-9-0-8-and-9-1-5-security-update-esa-2025-20/382449)
- [Drupal Security Advisory SA-CORE-2024-006](https://www.drupal.org/sa-core-2024-006) - CVE-2024-55636
- [CVE-2024-55636 Details](https://nvd.nist.gov/vuln/detail/CVE-2024-55636)
- Versions patchées Elasticsearch/Kibana : 8.18.8, 8.19.5, 9.0.8, 9.1.5
- Versions patchées Drupal : 10.2.11, 10.3.9, 11.0.8, 11.1.x, 11.2.5
- Registre Docker officiel Elastic : docker.elastic.co
- Registre Docker officiel Drupal : Docker Hub (_/drupal)

### Prochaines étapes de sécurité

- Surveiller les GitHub Security Alerts
- Exécuter les scans Trivy hebdomadaires via GitHub Actions
- Mettre à jour régulièrement les images Docker vers les dernières versions patchées
- Considérer l'upgrade vers Elasticsearch/Kibana 9.x après tests de compatibilité

## Repository

https://github.com/aboigues/drupal-mania.git
