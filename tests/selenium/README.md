# Tests Selenium pour Drupal Mania

Tests automatisés end-to-end utilisant Selenium WebDriver pour valider le bon fonctionnement de l'application Drupal.

## Prérequis

- Python 3.11+
- Chrome ou Chromium
- ChromeDriver
- Docker et Docker Compose (pour l'environnement de test)

## Installation

```bash
# Installer les dépendances Python
pip install -r requirements.txt

# Sur Ubuntu/Debian
sudo apt-get install chromium-browser chromium-chromedriver

# Sur macOS
brew install chromedriver
```

## Exécution des tests

### En local

```bash
# 1. Démarrer l'environnement Docker
cd ../..  # Revenir à la racine du projet
docker compose up -d

# 2. Attendre que Drupal soit prêt
curl http://localhost:8080

# 3. Lancer les tests
cd tests/selenium
pytest test_drupal_basic.py -v -s

# 4. Générer un rapport HTML
pytest test_drupal_basic.py -v -s --html=report.html --self-contained-html
```

### Via GitHub Actions

Les tests s'exécutent automatiquement :
- Sur les push vers `main` et `claude/**`
- Sur les pull requests vers `main`
- Manuellement via l'interface GitHub Actions

## Tests inclus

### TestDrupalHomePage
- `test_homepage_loads` - Vérifie que la page d'accueil charge avec un titre
- `test_homepage_status` - Vérifie l'URL et le statut HTTP
- `test_page_contains_html` - Vérifie la présence de la balise `<body>`
- `test_drupal_page_structure` - Vérifie la structure HTML de base

### TestDrupalNavigation
- `test_user_login_page_exists` - Vérifie l'accès à /user/login
- `test_can_navigate_to_user_page` - Vérifie la navigation vers /user

### TestDrupalResponsiveness
- `test_page_loads_within_timeout` - Vérifie le temps de chargement < 30s
- `test_multiple_page_loads` - Vérifie 3 chargements successifs

## Configuration

### Variables d'environnement

- `DRUPAL_URL` - URL de base de Drupal (défaut: `http://localhost:8080`)

```bash
export DRUPAL_URL=http://localhost:8080
pytest test_drupal_basic.py -v
```

### Options Chrome

Les tests utilisent Chrome en mode headless avec les options suivantes :
- `--headless` - Pas d'interface graphique
- `--no-sandbox` - Nécessaire pour CI/CD
- `--disable-dev-shm-usage` - Évite les problèmes de mémoire partagée
- `--disable-gpu` - Désactive l'accélération GPU
- `--window-size=1920,1080` - Résolution fixe

## Structure des fichiers

```
tests/selenium/
├── README.md                 # Ce fichier
├── __init__.py              # Package Python
├── requirements.txt         # Dépendances
└── test_drupal_basic.py    # Tests basiques
```

## Ajout de nouveaux tests

Pour ajouter de nouveaux tests, créez une nouvelle classe dans `test_drupal_basic.py` ou un nouveau fichier :

```python
class TestDrupalForms:
    """Tests des formulaires Drupal"""

    def test_contact_form_exists(self, driver, base_url):
        """Vérifie l'existence du formulaire de contact"""
        driver.get(f"{base_url}/contact")
        form = driver.find_element(By.TAG_NAME, 'form')
        assert form is not None
```

## Troubleshooting

### ChromeDriver version mismatch

```bash
# Vérifier les versions
google-chrome --version
chromedriver --version

# Mettre à jour ChromeDriver
# Ubuntu/Debian
sudo apt-get update && sudo apt-get upgrade chromium-chromedriver

# macOS
brew upgrade chromedriver
```

### Timeouts

Si les tests échouent avec des timeouts, vérifiez :

1. Drupal est bien démarré : `curl http://localhost:8080`
2. Les logs Docker : `docker compose logs drupal`
3. Augmentez les timeouts dans le code si nécessaire

### Erreurs de connexion

```bash
# Vérifier que tous les services sont up
docker compose ps

# Redémarrer si nécessaire
docker compose restart drupal
```

## Intégration Continue

Le workflow GitHub Actions (`.github/workflows/selenium-tests.yml`) :

1. Configure Python 3.11
2. Installe Chrome et ChromeDriver
3. Démarre Docker Compose
4. Attend que Drupal soit prêt
5. Exécute les tests
6. Génère et upload le rapport HTML
7. Nettoie l'environnement

Les rapports sont conservés 30 jours et téléchargeables depuis l'interface GitHub Actions.

## Ressources

- [Documentation Selenium](https://www.selenium.dev/documentation/)
- [Documentation pytest](https://docs.pytest.org/)
- [pytest-html](https://pytest-html.readthedocs.io/)
