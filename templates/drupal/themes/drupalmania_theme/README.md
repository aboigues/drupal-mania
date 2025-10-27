# Drupal Mania Theme

Thème Drupal 10 personnalisé pour le projet Drupal Mania.

## Description

Ce thème est un thème de base moderne pour Drupal 10, basé sur le thème stable9 avec des styles personnalisés et des fonctionnalités responsive.

## Structure

```
drupalmania_theme/
├── css/
│   ├── style.css           # Styles principaux
│   └── responsive.css      # Styles responsive
├── js/
│   └── scripts.js          # Scripts JavaScript
├── templates/
│   ├── page.html.twig      # Template de page
│   └── node.html.twig      # Template de node
├── images/                 # Images du thème
├── drupalmania_theme.info.yml      # Configuration du thème
├── drupalmania_theme.libraries.yml # Définition des bibliothèques CSS/JS
├── drupalmania_theme.theme         # Fonctions PHP du thème
└── README.md               # Ce fichier
```

## Installation

### Méthode 1: Via Docker (recommandé)

1. Copiez ce dossier dans `data/drupal/themes/` du projet
2. Le thème sera automatiquement disponible dans Drupal

### Méthode 2: Installation manuelle

1. Copiez ce dossier dans `web/themes/custom/` de votre installation Drupal
2. Allez dans **Apparence** dans l'interface d'administration
3. Installez et définissez le thème comme défaut

## Fonctionnalités

- **Responsive Design**: Optimisé pour mobile, tablette et desktop
- **Régions personnalisables**: Header, menu principal, menu secondaire, breadcrumb, contenu, sidebars, footer
- **CSS Variables**: Utilisation de variables CSS pour une personnalisation facile
- **JavaScript moderne**: Scripts Drupal behaviors pour une intégration propre
- **Templates Twig**: Templates personnalisés pour pages et nodes
- **Hooks**: Fonctions PHP pour étendre les fonctionnalités

## Personnalisation

### Couleurs

Modifiez les variables CSS dans `css/style.css`:

```css
:root {
  --primary-color: #0073aa;
  --secondary-color: #23282d;
  --text-color: #333;
  --bg-color: #f5f5f5;
}
```

### Régions

Ajoutez ou modifiez les régions dans `drupalmania_theme.info.yml`:

```yaml
regions:
  custom_region: 'Custom Region'
```

### Templates

Créez de nouveaux templates dans le dossier `templates/` en suivant les conventions de nommage Drupal.

## Développement

### Vider le cache

Après modification des fichiers du thème:

```bash
drush cr
```

Ou via l'interface: **Configuration** > **Développement** > **Performances** > **Vider tous les caches**

### Debugging Twig

Activez le mode debug dans `services.yml`:

```yaml
parameters:
  twig.config:
    debug: true
    auto_reload: true
    cache: false
```

## Support

Pour les questions et problèmes, créez une issue sur le repository du projet.

## License

Ce thème est fourni tel quel pour le projet Drupal Mania.
