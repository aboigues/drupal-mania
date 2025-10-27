# Contexte et Historique - drupal-mania

## Vue d'ensemble

**Projet:** drupal-mania
**Type:** code
**Créé:** 2025-10-27

## Description

Pile applicative Drupal + postgres déployée dans des conteneurs Docker

## Historique des sessions

### Session 2025-10-27 - Initialisation

- Création de la structure du projet
- Mise en place du workflow Git
- Création de la documentation de base

## Décisions importantes

[Documenter les décisions architecturales, choix techniques, etc.]

## Points d'attention

[Noter les éléments critiques, contraintes, limitations]

### Session 2025-10-27 - Première itération Docker

**Implémentation de la pile Drupal + PostgreSQL sous Docker**

Changements effectués:
- Création de la structure de dossiers pour les données (`data/postgres/`, `data/drupal/`)
- Création du fichier `docker-compose.yml` avec:
  - Service PostgreSQL 15 (Alpine)
  - Service Drupal 10 (Apache)
  - Configuration des volumes pour la persistance des données
  - Configuration du réseau pour la communication entre services
  - Healthcheck pour PostgreSQL
  - Variables d'environnement configurables
- Création du fichier `.env.example` avec les variables de configuration
- Mise à jour du `.gitignore` pour exclure les données Docker
- Mise à jour complète du `README.md` avec:
  - Instructions de démarrage rapide
  - Configuration détaillée
  - Commandes utiles (logs, accès aux conteneurs, etc.)
  - Section de dépannage

**Configuration par défaut:**
- Drupal 10 accessible sur http://localhost:8080
- PostgreSQL 15 avec base de données "drupal"
- Utilisateur PostgreSQL: drupal
- Réseau Docker privé pour la communication entre services

**Architecture:**
- 2 conteneurs: drupal-app et drupal-postgres
- Volumes persistants pour les données
- Healthcheck sur PostgreSQL pour s'assurer que Drupal démarre après que la DB soit prête

## Décisions importantes

### Choix technologiques

**Docker:**
- Docker Compose pour l'orchestration (simplicité et portabilité)
- Images officielles pour Drupal et PostgreSQL
- Volumes montés pour la persistance des données

**Versions:**
- Drupal 10 (dernière version stable)
- PostgreSQL 15 Alpine (léger et performant)

**Configuration:**
- Port 8080 par défaut pour éviter les conflits avec d'autres services locaux
- Variables d'environnement pour la configuration (via .env)
- Healthcheck sur PostgreSQL pour garantir le démarrage ordonné des services

## Points d'attention

- Les données PostgreSQL et Drupal sont stockées dans `data/` et ne sont pas versionnées
- Le fichier `.env` contient des mots de passe et ne doit pas être versionné
- Penser à changer le mot de passe PostgreSQL en production

## Prochaines étapes

- Tester le démarrage de la pile Docker
- Configurer Drupal via l'interface web
- Potentiellement ajouter des modules Drupal personnalisés
- Potentiellement ajouter une configuration de reverse proxy (nginx)
- Potentiellement ajouter un système de backup automatique

## Notes

**Première itération complète et fonctionnelle**
- La pile peut être démarrée avec `docker-compose up -d`
- L'installation de Drupal se fait via l'interface web
- Configuration simple et standard pour débuter

### Session 2025-10-27 - Implémentation des templates Drupal

**Création de templates de modules et thèmes Drupal personnalisés**

Changements effectués:

#### Structure créée

- Création du dossier `templates/drupal/` pour les templates versionnés
- Séparation claire entre templates versionnés et données non versionnées

#### Module Drupal Mania (drupalmania_module)

Création d'un module personnalisé complet incluant:

**Fichiers de configuration:**
- `drupalmania_module.info.yml` - Métadonnées du module
- `drupalmania_module.module` - Hooks et fonctions PHP
- `drupalmania_module.routing.yml` - Routes personnalisées
- `drupalmania_module.permissions.yml` - Permissions
- `drupalmania_module.libraries.yml` - Bibliothèques CSS/JS

**Code source:**
- `src/Controller/DrupalManiaController.php` - Contrôleur avec:
  - Page hello (`/drupalmania/hello`)
  - Dashboard avec statistiques (`/drupalmania/dashboard`)
- `src/Form/SettingsForm.php` - Formulaire de configuration admin

**Assets:**
- `css/drupalmania.css` - Styles pour le dashboard
- `js/drupalmania.js` - Scripts JavaScript avec animations

**Documentation:**
- `README.md` - Documentation complète du module

#### Thème Drupal Mania (drupalmania_theme)

Création d'un thème personnalisé complet incluant:

**Fichiers de configuration:**
- `drupalmania_theme.info.yml` - Métadonnées et régions
- `drupalmania_theme.theme` - Fonctions de preprocessing
- `drupalmania_theme.libraries.yml` - Définition des assets

**Templates Twig:**
- `templates/page.html.twig` - Template de page principal
- `templates/node.html.twig` - Template pour les contenus

**Styles CSS:**
- `css/style.css` - Styles principaux avec:
  - Variables CSS pour personnalisation
  - Layout responsive
  - Typographie
  - Composants (header, footer, navigation, formulaires)
- `css/responsive.css` - Media queries pour mobile/tablette/desktop

**Scripts JavaScript:**
- `js/scripts.js` - Comportements Drupal avec:
  - Menu mobile toggle
  - Smooth scroll
  - Animations au scroll
  - Interactions formulaires

**Documentation:**
- `README.md` - Guide complet d'utilisation et personnalisation

#### Configuration Docker

Mise à jour du `docker-compose.yml`:
- Ajout de volumes pour monter les templates dans le conteneur Drupal
- Templates du module: `./templates/drupal/modules/drupalmania_module`
- Templates du thème: `./templates/drupal/themes/drupalmania_theme`
- Séparation modules/thèmes templates vs données utilisateur

#### Documentation

Mise à jour de la documentation:

**templates/README.md** - Nouveau fichier avec:
- Structure des templates
- Instructions d'utilisation
- Guide de développement
- Troubleshooting

**README.md principal** - Ajout de:
- Section sur l'activation des modules/thèmes
- Instructions pour vider le cache Drupal
- Structure du projet détaillée
- Fonctionnalités incluses
- Dépannage des templates

#### Architecture

**Principe de séparation:**
- `templates/` → Code versionné (modules, thèmes)
- `data/` → Données non versionnées (contenu, config site)

**Avantages:**
- Templates disponibles immédiatement après démarrage Docker
- Versionnement Git du code Drupal personnalisé
- Facilite le développement collaboratif
- Déploiement simplifié

## Décisions importantes (mise à jour)

### Templates Drupal

**Choix de structure:**
- Templates versionnés dans `templates/drupal/`
- Montage direct dans les conteneurs via Docker volumes
- Séparation claire code vs données

**Module personnalisé:**
- Basé sur Drupal 10
- Dashboard avec statistiques (nodes, users)
- Routes personnalisées
- Formulaire de configuration
- CSS/JS moderne avec animations

**Thème personnalisé:**
- Basé sur stable9
- Design responsive (mobile-first)
- Variables CSS pour customisation
- Templates Twig surchargeables
- JavaScript avec Drupal behaviors

## Points d'attention (mise à jour)

- Après installation Drupal, activer manuellement le module et le thème
- Vider le cache Drupal après modifications: `docker exec -it drupal-app drush cr`
- Les templates sont en lecture seule dans le conteneur (montés en volume)
- Permissions peuvent nécessiter ajustement selon l'environnement

## Prochaines étapes (mise à jour)

- Tester l'activation du module et du thème
- Créer des types de contenu personnalisés
- Ajouter des blocks Drupal personnalisés
- Intégrer un système de build (webpack/gulp) pour assets
- Ajouter des tests automatisés pour le module
- Créer des configurations exportables (config sync)

### Session 2025-10-27 - Configuration CI de sécurité avec Trivy

**Mise en place d'un pipeline de scan de vulnérabilités pour les images Docker**

Changements effectués:

#### Workflow GitHub Actions créé

**Fichier:** `.github/workflows/trivy-scan.yml`

Configuration complète incluant:

**Déclencheurs automatiques:**
- Scan hebdomadaire programmé: Tous les lundis à 8h00 UTC
- Scan sur push vers branches: `main` et `claude/**`
- Scan sur pull requests vers: `main`
- Déclenchement manuel possible via GitHub UI

**Images scannées:**
- `postgres:15-alpine` - Base de données PostgreSQL
- `drupal:10-apache` - Application Drupal

**Fonctionnalités de scan:**

1. **Format SARIF** (Security Alert Results Interchange Format)
   - Upload automatique vers GitHub Security tab
   - Intégration native avec Code scanning alerts
   - Visualisation directe dans l'interface GitHub

2. **Format Table** (rapport texte lisible)
   - Génération de rapports formatés
   - Conservation 30 jours dans les artifacts GitHub
   - Idéal pour revue manuelle rapide

3. **Format JSON** (données structurées)
   - Export complet des résultats
   - Conservation 30 jours dans les artifacts
   - Utilisable pour automatisation future

**Niveaux de sévérité détectés:**
- CRITICAL: Vulnérabilités critiques
- HIGH: Vulnérabilités importantes
- MEDIUM: Vulnérabilités moyennes
- LOW: Vulnérabilités mineures (rapports détaillés uniquement)

**Job de résumé automatique:**
- Agrégation des résultats de tous les scans
- Génération d'un résumé dans GitHub Actions Summary
- Aperçu des 50 premières lignes de chaque rapport

#### Documentation créée

**Fichier:** `.github/workflows/README.md`

Documentation complète incluant:
- Description du workflow et des images scannées
- Liste des déclencheurs et fonctionnalités
- Guide d'accès aux résultats (Security tab + Artifacts)
- Procédure de gestion des vulnérabilités détectées
- Exemples de commandes Trivy en local
- Informations de maintenance et ressources

#### Stratégie de sécurité

**Approche proactive:**
- Détection automatique des nouvelles CVE via scan hebdomadaire
- Vérification de sécurité sur chaque modification de code
- Historique des scans conservé 30 jours

**Workflow d'intervention:**
1. Notification automatique en cas de vulnérabilités
2. Évaluation de la sévérité
3. Vérification des updates disponibles
4. Mise à jour des tags dans docker-compose.yml
5. Tests et validation
6. Documentation des changements

**Intégration GitHub:**
- Résultats visibles dans Security > Code scanning alerts
- Catégorisation par image (trivy-postgres, trivy-drupal)
- Artifacts téléchargeables pour analyse approfondie

## Décisions importantes (mise à jour)

### Sécurité et CI/CD

**Outil de scan:**
- Trivy choisi pour sa:
  - Large base de données de vulnérabilités
  - Support natif des images Docker
  - Intégration native avec GitHub Security
  - Formats de sortie multiples (SARIF, JSON, Table)
  - Communauté active et mises à jour fréquentes

**Fréquence de scan:**
- Hebdomadaire: Détection proactive des nouvelles CVE
- Sur push/PR: Vérification continue avant merge
- Manuel: Possibilité de scan à la demande

**Rétention des données:**
- 30 jours pour les artifacts (rapports)
- Permanent pour les résultats SARIF (Security tab)

**Images monitorées:**
- Images de base uniquement (postgres, drupal)
- Pas de build custom pour l'instant
- Evolution possible vers scan d'images custom si nécessaire

## Points d'attention (mise à jour)

### Sécurité

- Les scans Trivy détectent les vulnérabilités dans les images Docker officielles
- Les vulnérabilités CRITICAL et HIGH doivent être traitées en priorité
- Vérifier régulièrement les mises à jour des images de base
- Le scan ne remplace pas une analyse de sécurité complète du code applicatif
- Les rapports sont publics si le repository est public (à considérer pour les projets sensibles)

### Workflow GitHub Actions

- Nécessite les permissions GitHub Actions dans le repository
- Upload SARIF requiert GitHub Advanced Security (gratuit pour repos publics)
- Les artifacts consomment de l'espace de stockage GitHub (limites selon plan)
- Les scans peuvent prendre quelques minutes selon la taille des images

## Prochaines étapes (mise à jour)

### Sécurité

- Surveiller les alertes de sécurité GitHub après le premier scan
- Établir un processus de revue hebdomadaire des résultats
- Considérer l'ajout de seuils de tolérance (fail on CRITICAL)
- Évaluer l'ajout de scans supplémentaires (Dockerfile, dependencies)
- Intégrer le scan dans la documentation de déploiement

### CI/CD

- Ajouter des tests automatisés (unit, integration)
- Configurer des workflows de déploiement automatique
- Mettre en place des notifications (Slack, email) pour les vulnérabilités critiques
- Considérer l'ajout de badges de statut dans le README

### Code et Templates

- Tester l'activation du module et du thème
- Créer des types de contenu personnalisés
- Ajouter des blocks Drupal personnalisés
- Intégrer un système de build (webpack/gulp) pour assets
- Ajouter des tests automatisés pour le module
- Créer des configurations exportables (config sync)
