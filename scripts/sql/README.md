# Scripts SQL pour Drupal

Ce répertoire contient des scripts SQL utiles pour l'administration et le test de l'installation Drupal.

## insert_sample_articles.sql

Script d'insertion d'articles de démonstration pour Drupal 11.

### Description

Ce script insère **12 articles complets** couvrant différents thèmes :

1. **Intelligence Artificielle et Société** - Les impacts de l'IA sur notre quotidien
2. **Énergies Renouvelables** - La transition énergétique durable
3. **Cybersécurité** - Protection des données à l'ère numérique
4. **NFT et Art Numérique** - La révolution créative
5. **Télétravail** - Nouveau paradigme professionnel
6. **Agriculture Urbaine** - Cultiver la ville de demain
7. **Véhicules Électriques** - Révolution de la mobilité
8. **Éducation Numérique** - Défis et opportunités
9. **Économie Circulaire** - Repenser la consommation
10. **Blockchain** - Applications au-delà des cryptomonnaies
11. **Santé Mentale** - Briser les tabous (article épinglé)
12. **Exploration Spatiale** - Nouvelle ère spatiale (article épinglé)

### Caractéristiques

- **Contenu riche** : Chaque article contient du HTML formaté avec titres, listes, paragraphes
- **Variété thématique** : Technologie, environnement, société, santé, espace
- **Dates échelonnées** : Articles datés entre aujourd'hui et 25 jours en arrière
- **Articles épinglés** : Les 2 derniers articles sont marqués comme "sticky"
- **Format** : HTML complet (full_html)
- **Statut** : Tous publiés et promus en page d'accueil

### Prérequis

- Installation Drupal 11 fonctionnelle
- Base de données PostgreSQL configurée
- Type de contenu "article" existant (installé par défaut avec Drupal)
- Conteneur Docker `drupal-postgres` en cours d'exécution

### Utilisation

#### Méthode 1 : Depuis l'hôte

```bash
# Se placer à la racine du projet
cd /home/user/drupal-mania

# Exécuter le script
docker exec -i drupal-postgres psql -U drupal -d drupal < scripts/sql/insert_sample_articles.sql
```

#### Méthode 2 : Depuis le conteneur

```bash
# Se connecter au conteneur PostgreSQL
docker exec -it drupal-postgres psql -U drupal -d drupal

# Dans le shell psql, exécuter :
\i /path/to/insert_sample_articles.sql
```

#### Méthode 3 : Copier et exécuter

```bash
# Copier le fichier dans le conteneur
docker cp scripts/sql/insert_sample_articles.sql drupal-postgres:/tmp/

# Exécuter dans le conteneur
docker exec -i drupal-postgres psql -U drupal -d drupal -f /tmp/insert_sample_articles.sql
```

### Vérification

Après l'exécution, vous pouvez vérifier que les articles ont été insérés :

```bash
# Se connecter à la base de données
docker exec -it drupal-postgres psql -U drupal -d drupal

# Requête SQL pour lister les articles
SELECT nid, title, FROM_UNIXTIME(created) as date_creation, status
FROM node_field_data
WHERE type = 'article' AND nid >= 1001
ORDER BY created DESC;
```

Ou directement dans l'interface Drupal :
1. Se connecter à Drupal : http://localhost:8080
2. Aller dans **Contenu** (Content)
3. Filtrer par type : **Article**

### Nettoyage (optionnel)

Pour supprimer les articles de démonstration et recommencer :

```sql
-- Supprimer uniquement les articles insérés par ce script (nid >= 1001)
DELETE FROM node__body WHERE entity_id >= 1001;
DELETE FROM node_field_data WHERE nid >= 1001;
DELETE FROM node WHERE nid >= 1001;
```

### Structure des Données

Le script insère des données dans les tables suivantes :

- **node** : Métadonnées de base du nœud
- **node_field_data** : Données traduisibles (titre, statut, dates)
- **node__body** : Corps de l'article (texte HTML)

### Personnalisation

Pour modifier les articles ou en ajouter :

1. Suivre le modèle d'un article existant dans le script
2. Choisir un nouveau `nid` (ex: 1013, 1014, etc.)
3. Adapter le contenu HTML dans `body_value`
4. Ajuster les métadonnées (titre, dates, etc.)

### IDs et Séquences

Les articles utilisent les IDs suivants :
- **nid** : 1001-1012 (Node ID)
- **vid** : 1001-1012 (Revision ID)

Les séquences sont initialisées à 1000 pour éviter les conflits avec le contenu existant.

### Notes Importantes

- Les articles sont créés en **français** (langcode: 'fr')
- L'utilisateur propriétaire est **uid: 1** (admin)
- Format de texte : **full_html** (nécessite les permissions appropriées)
- Les UUIDs sont générés automatiquement avec `gen_random_uuid()`

### Dépannage

#### Erreur : "relation node does not exist"
- Drupal n'est pas installé ou la base de données n'est pas initialisée
- Solution : Installer Drupal via l'interface web

#### Erreur : "duplicate key value"
- Des articles avec ces IDs existent déjà
- Solution : Utiliser le script de nettoyage ou choisir d'autres IDs

#### Les articles n'apparaissent pas
- Vérifier que Drupal est bien installé
- Vider le cache Drupal : Configuration > Performance > Clear all caches
- Vérifier les permissions du rôle anonyme/authentifié

## Autres Scripts

Ce répertoire peut contenir d'autres scripts SQL utiles :

- Scripts de migration
- Scripts de nettoyage
- Scripts d'export/import de données
- Scripts de configuration

## Contribution

Pour ajouter de nouveaux scripts :

1. Créer le fichier `.sql` dans ce répertoire
2. Documenter son utilisation dans ce README
3. Ajouter des commentaires dans le script SQL
4. Tester avant de commiter

## Ressources

- [Documentation Drupal](https://www.drupal.org/docs)
- [Structure de la base de données Drupal](https://www.drupal.org/docs/drupal-apis/entity-api/introduction-to-entity-api-in-drupal-8)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
