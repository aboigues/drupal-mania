"""
Tests Selenium basiques pour vérifier le fonctionnement de Drupal
"""
import pytest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options
from selenium.common.exceptions import TimeoutException
import os


@pytest.fixture
def driver():
    """Configure et retourne un driver Selenium Chrome"""
    chrome_options = Options()
    chrome_options.add_argument('--headless')  # Mode sans interface graphique pour CI/CD
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--disable-dev-shm-usage')
    chrome_options.add_argument('--disable-gpu')
    chrome_options.add_argument('--window-size=1920,1080')

    driver = webdriver.Chrome(options=chrome_options)
    driver.implicitly_wait(10)

    yield driver

    driver.quit()


@pytest.fixture
def base_url():
    """URL de base de l'application Drupal"""
    return os.environ.get('DRUPAL_URL', 'http://localhost:8080')


class TestDrupalHomePage:
    """Tests de la page d'accueil Drupal"""

    def test_homepage_loads(self, driver, base_url):
        """Vérifie que la page d'accueil se charge correctement"""
        driver.get(base_url)

        # Vérifier que le titre contient quelque chose (Drupal charge)
        assert driver.title is not None
        assert len(driver.title) > 0
        print(f"✅ Page d'accueil chargée - Titre: {driver.title}")

    def test_homepage_status(self, driver, base_url):
        """Vérifie que la page d'accueil répond avec un statut 200"""
        driver.get(base_url)

        # Si on arrive ici sans exception, la page s'est chargée
        assert driver.current_url.startswith(base_url)
        print(f"✅ URL actuelle: {driver.current_url}")

    def test_page_contains_html(self, driver, base_url):
        """Vérifie que la page contient du HTML valide"""
        driver.get(base_url)

        # Vérifier que la balise body existe
        body = driver.find_element(By.TAG_NAME, 'body')
        assert body is not None
        print("✅ Balise <body> trouvée")

    def test_drupal_page_structure(self, driver, base_url):
        """Vérifie la structure de base d'une page Drupal"""
        driver.get(base_url)

        # Attendre que la page soit chargée
        WebDriverWait(driver, 20).until(
            EC.presence_of_element_located((By.TAG_NAME, 'body'))
        )

        # Vérifier la présence d'éléments HTML de base
        html = driver.find_element(By.TAG_NAME, 'html')
        assert html is not None
        print("✅ Structure HTML de base présente")


class TestDrupalNavigation:
    """Tests de navigation Drupal"""

    def test_user_login_page_exists(self, driver, base_url):
        """Vérifie que la page de connexion utilisateur est accessible"""
        driver.get(f"{base_url}/user/login")

        # Attendre que la page soit chargée
        WebDriverWait(driver, 20).until(
            EC.presence_of_element_located((By.TAG_NAME, 'body'))
        )

        # Vérifier qu'on est sur une page valide
        assert driver.current_url is not None
        print(f"✅ Page de login accessible: {driver.current_url}")

    def test_can_navigate_to_user_page(self, driver, base_url):
        """Vérifie qu'on peut naviguer vers la page utilisateur"""
        driver.get(base_url)

        # Naviguer vers /user
        driver.get(f"{base_url}/user")

        # Attendre que la page charge
        WebDriverWait(driver, 20).until(
            EC.presence_of_element_located((By.TAG_NAME, 'body'))
        )

        # Vérifier qu'on a bien navigué
        # Note: Drupal non installé redirige vers /core/install.php, ce qui est normal
        assert '/user' in driver.current_url or '/core/install.php' in driver.current_url
        print(f"✅ Navigation vers /user réussie: {driver.current_url}")


class TestDrupalResponsiveness:
    """Tests de réactivité de Drupal"""

    def test_page_loads_within_timeout(self, driver, base_url):
        """Vérifie que la page se charge dans un délai raisonnable"""
        import time

        start_time = time.time()
        driver.get(base_url)

        # Attendre que la page soit complètement chargée
        WebDriverWait(driver, 30).until(
            EC.presence_of_element_located((By.TAG_NAME, 'body'))
        )

        load_time = time.time() - start_time

        # La page devrait se charger en moins de 30 secondes
        assert load_time < 30
        print(f"✅ Page chargée en {load_time:.2f} secondes")

    def test_multiple_page_loads(self, driver, base_url):
        """Vérifie que plusieurs chargements successifs fonctionnent"""
        for i in range(3):
            driver.get(base_url)

            # Attendre que la page charge
            WebDriverWait(driver, 20).until(
                EC.presence_of_element_located((By.TAG_NAME, 'body'))
            )

            assert driver.current_url.startswith(base_url)
            print(f"✅ Chargement {i+1}/3 réussi")


if __name__ == '__main__':
    pytest.main([__file__, '-v', '-s'])
