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
