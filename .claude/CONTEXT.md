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
