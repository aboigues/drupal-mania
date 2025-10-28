# Templates Drupal

Ce dossier contient les templates de modules et thèmes Drupal personnalisés, versionnés dans Git.

## Structure

```
templates/
└── drupal/
    ├── modules/
    │   └── drupalmania_module/    # Module personnalisé principal
    └── themes/
        └── drupalmania_theme/     # Thème personnalisé principal
```

## Utilisation

### Avec Docker Compose

Les templates sont automatiquement montés dans les conteneurs Docker grâce au `docker compose.yml`:

```yaml
volumes:
  - ./templates/drupal/modules/drupalmania_module:/opt/drupal/web/modules/custom/drupalmania_module
  - ./templates/drupal/themes/drupalmania_theme:/opt/drupal/web/themes/custom/drupalmania_theme
```

Après avoir démarré les conteneurs avec `docker compose up -d`, les modules et thèmes seront disponibles dans Drupal.

### Activer le module

1. Accédez à l'interface d'administration: `http://localhost:8080/admin`
2. Allez dans **Extend** (Extensions)
3. Cherchez "Drupal Mania Module"
4. Cochez la case et cliquez sur "Install"

### Activer le thème

1. Accédez à l'interface d'administration: `http://localhost:8080/admin`
2. Allez dans **Appearance** (Apparence)
3. Cherchez "Drupal Mania Theme"
4. Cliquez sur "Install and set as default"

## Développement

### Modifier les templates

Les fichiers sont montés en volume, donc toute modification est immédiatement visible (après vidage du cache):

```bash
# Dans le conteneur Drupal
docker exec -it drupal-app drush cr

# Ou via l'interface admin
Configuration > Development > Performance > Clear all caches
```

### Ajouter un nouveau module ou thème

1. Créez un nouveau dossier dans `templates/drupal/modules/` ou `templates/drupal/themes/`
2. Ajoutez le volume correspondant dans `docker compose.yml`
3. Redémarrez les conteneurs: `docker compose restart`
4. Le nouveau module/thème sera disponible dans Drupal

## Templates fournis

### Drupal Mania Module

Module personnalisé avec:
- Dashboard avec statistiques
- Pages personnalisées
- Formulaire de configuration
- Hooks et intégrations

Voir: [templates/drupal/modules/drupalmania_module/README.md](drupal/modules/drupalmania_module/README.md)

### Drupal Mania Theme

Thème personnalisé avec:
- Design responsive
- Variables CSS personnalisables
- Templates Twig
- JavaScript moderne

Voir: [templates/drupal/themes/drupalmania_theme/README.md](drupal/themes/drupalmania_theme/README.md)

## Best Practices

### Versionner les templates

Les templates dans ce dossier sont versionnés dans Git. Cela permet:
- De partager le code entre développeurs
- De garder un historique des modifications
- De déployer facilement sur différents environnements

### Données vs Templates

- **templates/** : Code versionné (modules, thèmes)
- **data/** : Données non versionnées (contenu, configuration site)

### Développement local

Pour développer localement:

1. Clonez le repository
2. Démarrez Docker: `docker compose up -d`
3. Modifiez les fichiers dans `templates/`
4. Videz le cache Drupal pour voir les changements
5. Committez vos modifications

## Troubleshooting

### Les modifications ne sont pas visibles

1. Videz le cache Drupal: `docker exec -it drupal-app drush cr`
2. Vérifiez que les volumes sont correctement montés: `docker inspect drupal-app`

### Le module/thème n'apparaît pas

1. Vérifiez le fichier `.info.yml`
2. Vérifiez que le volume est bien défini dans `docker compose.yml`
3. Redémarrez les conteneurs: `docker compose restart`
4. Videz le cache: `docker exec -it drupal-app drush cr`

### Erreurs de permissions

Si vous avez des erreurs de permissions:

```bash
# Corriger les permissions
docker exec -it drupal-app chown -R www-data:www-data /opt/drupal/web/modules/custom
docker exec -it drupal-app chown -R www-data:www-data /opt/drupal/web/themes/custom
```

## Documentation

- [Drupal 10 Documentation](https://www.drupal.org/docs/10)
- [Creating Modules](https://www.drupal.org/docs/creating-custom-modules)
- [Theming Guide](https://www.drupal.org/docs/theming-drupal)
- [Twig in Drupal](https://www.drupal.org/docs/theming-drupal/twig-in-drupal)
