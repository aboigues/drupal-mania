# GitHub Actions Workflows

Ce répertoire contient les workflows GitHub Actions pour assurer la qualité et la sécurité du projet drupal-mania.

## Vue d'ensemble

| Workflow | Description | Déclenchement |
|----------|-------------|---------------|
| **Trivy Security Scan** | Scan de sécurité des images Docker | Hebdomadaire + Push/PR |
| **Docker Compose Test** | Test du bon fonctionnement du stack | Push/PR |

---

## Docker Compose Test

### Description

Ce workflow teste automatiquement que le stack Docker Compose (PostgreSQL + Drupal) démarre et fonctionne correctement.

### Tests effectués

1. ✅ **Création des répertoires** : Vérifie que tous les volumes requis peuvent être créés
2. ✅ **Démarrage des services** : Lance `docker-compose up -d`
3. ✅ **Health check PostgreSQL** : Attend jusqu'à 60 secondes que PostgreSQL soit sain
4. ✅ **Disponibilité Drupal** : Vérifie que Drupal répond (timeout 120s)
5. ✅ **Test HTTP** : Valide la réponse HTTP (codes 200, 301, 302 acceptés)
6. ✅ **Connexion PostgreSQL** : Teste la connectivité à la base de données
7. ✅ **Logs de debug** : Affiche les logs en cas d'échec
8. ✅ **Nettoyage** : Supprime les containers et volumes après les tests

### Déclencheurs

Le test s'exécute automatiquement dans les cas suivants :

1. **Push** : Sur les branches `main` et `claude/**`
2. **Pull Request** : Vers la branche `main`
3. **Manuel** : Via le bouton "Run workflow" dans l'interface GitHub Actions

### Variables d'environnement de test

Le workflow utilise des valeurs de test spécifiques :

```env
POSTGRES_DB=drupal_test
POSTGRES_USER=drupal_test
POSTGRES_PASSWORD=test_password_123
DRUPAL_PORT=8080
```

### Accéder aux résultats

1. Aller dans l'onglet **Actions** du repository
2. Sélectionner le workflow "Docker Compose Test"
3. Cliquer sur un run spécifique pour voir les détails
4. Le résumé est disponible dans l'onglet "Summary"

### Que faire en cas d'échec ?

Si le test échoue, voici les étapes de diagnostic :

1. **Consulter les logs** : Ils sont automatiquement affichés en cas d'échec
2. **Vérifier le docker-compose.yml** : S'assurer que la configuration est valide
3. **Tester localement** :
   ```bash
   docker-compose up -d
   docker-compose ps
   docker-compose logs
   ```
4. **Vérifier les volumes** : S'assurer que les répertoires data/ sont accessibles
5. **Vérifier les ports** : Le port 8080 ne doit pas être déjà utilisé

### Exemples de commandes locales

Pour reproduire les tests localement :

```bash
# Démarrer les services
docker-compose up -d

# Vérifier le statut
docker-compose ps

# Tester PostgreSQL
docker-compose exec postgres psql -U drupal -d drupal -c "SELECT version();"

# Tester Drupal
curl -I http://localhost:8080

# Voir les logs
docker-compose logs drupal
docker-compose logs postgres

# Nettoyer
docker-compose down -v
```

---

## Trivy Security Scan

### Description

Ce workflow utilise [Trivy](https://github.com/aquasecurity/trivy) pour scanner les vulnérabilités de sécurité dans les images Docker utilisées par le projet.

### Images scannées

- **postgres:15-alpine** - Base de données PostgreSQL
- **drupal:10-apache** - Application Drupal

### Déclencheurs

Le scan s'exécute automatiquement dans les cas suivants :

1. **Planification** : Tous les lundis à 8h00 UTC
2. **Push** : Sur les branches `main` et `claude/**`
3. **Pull Request** : Vers la branche `main`
4. **Manuel** : Via le bouton "Run workflow" dans l'interface GitHub Actions

### Fonctionnalités

#### Rapports générés

1. **SARIF** : Intégration avec GitHub Security tab
   - Permet de visualiser les vulnérabilités directement dans l'interface GitHub
   - Disponible dans Security > Code scanning alerts

2. **Table** : Rapport lisible en format texte
   - Conservé pendant 30 jours dans les artifacts
   - Idéal pour une lecture rapide

3. **JSON** : Rapport détaillé en format structuré
   - Conservé pendant 30 jours dans les artifacts
   - Utilisable pour l'automatisation et l'analyse

#### Niveaux de sévérité

Les scans détectent les vulnérabilités aux niveaux suivants :
- **CRITICAL** : Vulnérabilités critiques nécessitant une action immédiate
- **HIGH** : Vulnérabilités importantes à corriger rapidement
- **MEDIUM** : Vulnérabilités moyennes à surveiller
- **LOW** : Vulnérabilités mineures (uniquement dans les rapports détaillés)

### Résumé automatique

Après chaque scan, un résumé est généré automatiquement dans l'onglet "Summary" du workflow, incluant :
- Date et heure du scan
- Aperçu des résultats pour chaque image
- Lien vers les rapports complets

### Configuration recommandée

#### Variables d'environnement (optionnelles)

Si vous souhaitez personnaliser le comportement, vous pouvez ajouter ces secrets dans GitHub :
- `TRIVY_SEVERITY` : Personnaliser les niveaux de sévérité à scanner
- `TRIVY_EXIT_CODE` : Définir le code de sortie en cas de vulnérabilités (0 ou 1)

### Accéder aux résultats

#### Via GitHub Security

1. Aller dans l'onglet **Security** du repository
2. Cliquer sur **Code scanning alerts**
3. Filtrer par catégorie : `trivy-postgres` ou `trivy-drupal`

#### Via les Artifacts

1. Aller dans l'onglet **Actions**
2. Sélectionner le workflow "Trivy Security Scan"
3. Télécharger les artifacts :
   - `trivy-report-postgres` : Rapport texte pour PostgreSQL
   - `trivy-report-drupal` : Rapport texte pour Drupal
   - `trivy-json-postgres` : Rapport JSON pour PostgreSQL
   - `trivy-json-drupal` : Rapport JSON pour Drupal

### Que faire en cas de vulnérabilités ?

1. **Évaluer la sévérité** : Prioriser les vulnérabilités CRITICAL et HIGH
2. **Vérifier les mises à jour** : Consulter si une nouvelle version de l'image est disponible
3. **Mettre à jour** : Modifier les tags d'images dans `docker-compose.yml`
4. **Tester** : Vérifier que l'application fonctionne avec la nouvelle version
5. **Documenter** : Noter les changements dans `CONTEXT.md`

### Exemples de commandes locales

Pour exécuter Trivy localement avant de pusher :

```bash
# Scanner l'image PostgreSQL
docker pull postgres:15-alpine
trivy image postgres:15-alpine

# Scanner l'image Drupal
docker pull drupal:10-apache
trivy image drupal:10-apache

# Générer un rapport JSON
trivy image --format json --output report.json postgres:15-alpine
```

### Maintenance

- Les rapports sont conservés **30 jours** dans les artifacts
- Les résultats SARIF sont disponibles dans Security indéfiniment
- Le scan hebdomadaire permet de détecter les nouvelles vulnérabilités

### Ressources

- [Documentation Trivy](https://aquasecurity.github.io/trivy/)
- [GitHub Actions Trivy Action](https://github.com/aquasecurity/trivy-action)
- [CVE Database](https://cve.mitre.org/)
