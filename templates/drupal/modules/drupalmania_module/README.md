# Drupal Mania Module

Module personnalisé pour Drupal 10 avec des fonctionnalités de base pour le projet Drupal Mania.

## Description

Ce module fournit des fonctionnalités personnalisées pour le site Drupal Mania, incluant:

- **Dashboard personnalisé**: Affiche des statistiques du site
- **Pages personnalisées**: Routes et contrôleurs pour des pages custom
- **Configuration**: Formulaire de configuration dans l'admin
- **Permissions**: Gestion des permissions pour accéder aux fonctionnalités
- **Hooks**: Divers hooks pour étendre Drupal

## Structure

```
drupalmania_module/
├── src/
│   ├── Controller/
│   │   └── DrupalManiaController.php    # Contrôleurs pour les pages
│   └── Form/
│       └── SettingsForm.php             # Formulaire de configuration
├── css/
│   └── drupalmania.css                  # Styles du module
├── js/
│   └── drupalmania.js                   # Scripts JavaScript
├── drupalmania_module.info.yml          # Configuration du module
├── drupalmania_module.module            # Hooks et fonctions
├── drupalmania_module.routing.yml       # Définition des routes
├── drupalmania_module.permissions.yml   # Permissions personnalisées
├── drupalmania_module.libraries.yml     # Bibliothèques CSS/JS
└── README.md                            # Ce fichier
```

## Installation

### Méthode 1: Via Docker (recommandé)

1. Copiez ce dossier dans `data/drupal/modules/` du projet
2. Le module sera automatiquement disponible dans Drupal

### Méthode 2: Installation manuelle

1. Copiez ce dossier dans `web/modules/custom/` de votre installation Drupal
2. Allez dans **Extend** dans l'interface d'administration
3. Activez le module "Drupal Mania Module"

## Fonctionnalités

### Pages disponibles

- `/drupalmania/hello` - Page de démonstration
- `/drupalmania/dashboard` - Dashboard avec statistiques
- `/admin/config/drupalmania` - Configuration du module (admin only)

### Permissions

Le module crée deux permissions:

1. **Access Drupal Mania Dashboard**: Permet d'accéder au dashboard
2. **Administer Drupal Mania**: Permet d'administrer le module

Pour configurer les permissions:
1. Allez dans **People** > **Permissions**
2. Cherchez "Drupal Mania"
3. Attribuez les permissions aux rôles appropriés

### Configuration

Pour configurer le module:

1. Allez dans **Configuration** > **Drupal Mania Settings**
2. Configurez les paramètres:
   - Message du site
   - Activation des fonctionnalités
   - Clé API
   - Nombre d'éléments par page

### Hooks implémentés

- `hook_help()`: Aide du module
- `hook_theme()`: Templates personnalisés
- `hook_page_attachments()`: Attache CSS/JS
- `hook_preprocess_node()`: Prétraitement des nodes
- `hook_form_alter()`: Modification des formulaires
- `hook_entity_presave()`: Actions avant sauvegarde
- `hook_cron()`: Tâches planifiées

## Développement

### Ajouter une nouvelle route

Éditez `drupalmania_module.routing.yml`:

```yaml
drupalmania_module.custom_page:
  path: '/drupalmania/custom'
  defaults:
    _controller: '\Drupal\drupalmania_module\Controller\DrupalManiaController::customPage'
    _title: 'Custom Page'
  requirements:
    _permission: 'access content'
```

### Créer un nouveau contrôleur

Dans `src/Controller/CustomController.php`:

```php
<?php

namespace Drupal\drupalmania_module\Controller;

use Drupal\Core\Controller\ControllerBase;

class CustomController extends ControllerBase {
  public function customPage() {
    return [
      '#markup' => $this->t('Custom page content'),
    ];
  }
}
```

### Vider le cache

Après modification:

```bash
drush cr
```

Ou via l'interface: **Configuration** > **Développement** > **Performances** > **Vider tous les caches**

## Dépannage

### Le module n'apparaît pas dans la liste

1. Vérifiez que le fichier `.info.yml` est correctement formaté
2. Videz le cache Drupal
3. Vérifiez que le module est dans le bon dossier

### Les routes ne fonctionnent pas

1. Videz le cache de routing: `drush cr`
2. Vérifiez la syntaxe du fichier `.routing.yml`
3. Vérifiez les permissions requises

### Les CSS/JS ne se chargent pas

1. Videz le cache
2. Vérifiez le fichier `.libraries.yml`
3. Vérifiez que les fichiers existent aux bons emplacements

## API

### Utiliser la configuration

```php
$config = \Drupal::config('drupalmania_module.settings');
$message = $config->get('site_message');
```

### Logger des messages

```php
\Drupal::logger('drupalmania_module')->notice('Message');
```

## Support

Pour les questions et problèmes, créez une issue sur le repository du projet.

## License

Ce module est fourni tel quel pour le projet Drupal Mania.
