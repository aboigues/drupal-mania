-- ============================================================================
-- Script d'insertion d'articles de démonstration pour Drupal 11
-- ============================================================================
-- Ce script insère des articles variés dans une installation Drupal
-- Base de données : PostgreSQL
-- Type de contenu : article
--
-- UTILISATION :
-- 1. S'assurer que Drupal est installé et configuré
-- 2. Se connecter au conteneur PostgreSQL :
--    docker exec -i drupal-postgres psql -U drupal -d drupal < scripts/sql/insert_sample_articles.sql
-- ============================================================================

-- Nettoyage optionnel (décommenter si besoin de réinitialiser)
-- DELETE FROM node__body WHERE bundle = 'article';
-- DELETE FROM node_field_data WHERE type = 'article';
-- DELETE FROM node WHERE type = 'article';

-- Configuration des séquences pour éviter les conflits d'ID
-- Les IDs commencent à 1000 pour éviter les conflits avec les contenus existants
SELECT setval('node_field_data_nid_seq', 1000, false);
SELECT setval('node_revision_revision_seq', 1000, false);

-- ============================================================================
-- ARTICLE 1 : Intelligence Artificielle et Société
-- ============================================================================

-- Insertion dans la table node
INSERT INTO node (nid, vid, type, uuid, langcode)
VALUES (
  1001,
  1001,
  'article',
  gen_random_uuid()::varchar,
  'fr'
);

-- Insertion dans node_field_data (données principales)
INSERT INTO node_field_data (
  nid, vid, type, langcode, status, uid, title, created, changed, promote, sticky, default_langcode, revision_translation_affected
)
VALUES (
  1001,
  1001,
  'article',
  'fr',
  1,
  1,
  'L''Intelligence Artificielle : Une Révolution en Marche',
  EXTRACT(EPOCH FROM NOW())::integer,
  EXTRACT(EPOCH FROM NOW())::integer,
  1,
  0,
  1,
  1
);

-- Insertion du corps de l'article
INSERT INTO node__body (
  bundle, deleted, entity_id, revision_id, langcode, delta, body_value, body_summary, body_format
)
VALUES (
  'article',
  0,
  1001,
  1001,
  'fr',
  0,
  '<p>L''intelligence artificielle (IA) transforme profondément notre société. Des assistants virtuels aux véhicules autonomes, en passant par les diagnostics médicaux, l''IA s''immisce dans tous les aspects de notre quotidien.</p>

<h2>Les Domaines d''Application</h2>

<p>Les applications de l''IA sont vastes et variées :</p>

<ul>
  <li><strong>Santé :</strong> Détection précoce des maladies, personnalisation des traitements</li>
  <li><strong>Transport :</strong> Véhicules autonomes, optimisation du trafic</li>
  <li><strong>Finance :</strong> Détection de fraudes, trading algorithmique</li>
  <li><strong>Éducation :</strong> Apprentissage personnalisé, tuteurs virtuels</li>
</ul>

<h2>Les Défis Éthiques</h2>

<p>Malgré ses promesses, l''IA soulève des questions éthiques importantes : protection de la vie privée, biais algorithmiques, impact sur l''emploi. Il est crucial d''encadrer son développement pour garantir qu''elle serve l''intérêt général.</p>

<p>L''avenir de l''IA dépendra de notre capacité à l''utiliser de manière responsable et éthique.</p>',
  '<p>Découvrez comment l''intelligence artificielle révolutionne notre société et les défis éthiques qu''elle pose.</p>',
  'full_html'
);

-- ============================================================================
-- ARTICLE 2 : Développement Durable
-- ============================================================================

INSERT INTO node (nid, vid, type, uuid, langcode)
VALUES (1002, 1002, 'article', gen_random_uuid()::varchar, 'fr');

INSERT INTO node_field_data (
  nid, vid, type, langcode, status, uid, title, created, changed, promote, sticky, default_langcode, revision_translation_affected
)
VALUES (
  1002, 1002, 'article', 'fr', 1, 1,
  'Les Énergies Renouvelables : Un Avenir Durable',
  EXTRACT(EPOCH FROM NOW() - INTERVAL '2 days')::integer,
  EXTRACT(EPOCH FROM NOW() - INTERVAL '2 days')::integer,
  1, 0, 1, 1
);

INSERT INTO node__body (
  bundle, deleted, entity_id, revision_id, langcode, delta, body_value, body_summary, body_format
)
VALUES (
  'article', 0, 1002, 1002, 'fr', 0,
  '<p>La transition énergétique vers les sources renouvelables n''est plus une option mais une nécessité. Face aux défis climatiques, l''humanité doit repenser sa production et sa consommation d''énergie.</p>

<h2>Les Principales Sources d''Énergie Renouvelable</h2>

<h3>Énergie Solaire</h3>
<p>Le solaire photovoltaïque connaît une croissance exponentielle. Les coûts ont chuté de 90% en 10 ans, rendant cette énergie compétitive.</p>

<h3>Énergie Éolienne</h3>
<p>L''éolien terrestre et offshore se développe rapidement. Les parcs éoliens marins peuvent produire une quantité considérable d''électricité.</p>

<h3>Hydroélectricité</h3>
<p>Première source d''électricité renouvelable au monde, l''hydroélectricité reste un pilier de la transition énergétique.</p>

<h2>Les Défis à Relever</h2>

<p>Le stockage de l''énergie, l''intermittence de la production et l''acceptabilité sociale sont autant de défis à relever pour réussir cette transition.</p>

<p>L''innovation technologique et la volonté politique seront déterminantes pour construire un avenir énergétique durable.</p>',
  '<p>Explorez les différentes sources d''énergie renouvelable et les défis de la transition énergétique.</p>',
  'full_html'
);

-- ============================================================================
-- ARTICLE 3 : Cybersécurité
-- ============================================================================

INSERT INTO node (nid, vid, type, uuid, langcode)
VALUES (1003, 1003, 'article', gen_random_uuid()::varchar, 'fr');

INSERT INTO node_field_data (
  nid, vid, type, langcode, status, uid, title, created, changed, promote, sticky, default_langcode, revision_translation_affected
)
VALUES (
  1003, 1003, 'article', 'fr', 1, 1,
  'Cybersécurité : Protéger ses Données à l''Ère Numérique',
  EXTRACT(EPOCH FROM NOW() - INTERVAL '3 days')::integer,
  EXTRACT(EPOCH FROM NOW() - INTERVAL '3 days')::integer,
  1, 0, 1, 1
);

INSERT INTO node__body (
  bundle, deleted, entity_id, revision_id, langcode, delta, body_value, body_summary, body_format
)
VALUES (
  'article', 0, 1003, 1003, 'fr', 0,
  '<p>Dans un monde de plus en plus connecté, la cybersécurité est devenue un enjeu majeur pour les individus, les entreprises et les gouvernements.</p>

<h2>Les Menaces Actuelles</h2>

<p>Les cyberattaques se multiplient et se sophistiquent :</p>

<ul>
  <li><strong>Ransomware :</strong> Des logiciels malveillants qui chiffrent les données et exigent une rançon</li>
  <li><strong>Phishing :</strong> Des emails frauduleux pour voler des identifiants</li>
  <li><strong>Attaques DDoS :</strong> Saturation des serveurs pour les rendre indisponibles</li>
  <li><strong>Fuites de données :</strong> Vol massif d''informations personnelles</li>
</ul>

<h2>Les Bonnes Pratiques</h2>

<h3>Pour les Utilisateurs</h3>
<ul>
  <li>Utiliser des mots de passe forts et uniques</li>
  <li>Activer l''authentification à deux facteurs</li>
  <li>Maintenir ses logiciels à jour</li>
  <li>Se méfier des emails suspects</li>
</ul>

<h3>Pour les Entreprises</h3>
<ul>
  <li>Former les employés à la sécurité</li>
  <li>Mettre en place des pare-feu et antivirus robustes</li>
  <li>Effectuer des audits de sécurité réguliers</li>
  <li>Avoir un plan de réponse aux incidents</li>
</ul>

<p>La cybersécurité est l''affaire de tous. Une vigilance constante est nécessaire pour protéger nos données et notre vie privée.</p>',
  '<p>Découvrez les menaces cybernétiques actuelles et les bonnes pratiques pour protéger vos données.</p>',
  'full_html'
);

-- ============================================================================
-- ARTICLE 4 : Culture et Arts Numériques
-- ============================================================================

INSERT INTO node (nid, vid, type, uuid, langcode)
VALUES (1004, 1004, 'article', gen_random_uuid()::varchar, 'fr');

INSERT INTO node_field_data (
  nid, vid, type, langcode, status, uid, title, created, changed, promote, sticky, default_langcode, revision_translation_affected
)
VALUES (
  1004, 1004, 'article', 'fr', 1, 1,
  'Les NFT et l''Art Numérique : Une Nouvelle Ère Créative',
  EXTRACT(EPOCH FROM NOW() - INTERVAL '5 days')::integer,
  EXTRACT(EPOCH FROM NOW() - INTERVAL '5 days')::integer,
  1, 0, 1, 1
);

INSERT INTO node__body (
  bundle, deleted, entity_id, revision_id, langcode, delta, body_value, body_summary, body_format
)
VALUES (
  'article', 0, 1004, 1004, 'fr', 0,
  '<p>Les NFT (Non-Fungible Tokens) ont révolutionné le monde de l''art numérique en permettant l''authentification et la propriété d''œuvres digitales.</p>

<h2>Qu''est-ce qu''un NFT ?</h2>

<p>Un NFT est un jeton cryptographique unique qui représente la propriété d''un actif numérique. Contrairement aux cryptomonnaies, chaque NFT est unique et non interchangeable.</p>

<h2>L''Impact sur les Artistes</h2>

<p>Les NFT offrent de nouvelles opportunités aux artistes numériques :</p>

<ul>
  <li><strong>Monétisation directe :</strong> Vente d''œuvres sans intermédiaire</li>
  <li><strong>Royalties automatiques :</strong> Revenus sur les reventes</li>
  <li><strong>Preuve d''authenticité :</strong> Traçabilité sur la blockchain</li>
  <li><strong>Accès global :</strong> Marché mondial instantané</li>
</ul>

<h2>Les Critiques et Controverses</h2>

<p>Malgré leur popularité, les NFT font face à des critiques :</p>

<ul>
  <li>Impact environnemental de la blockchain</li>
  <li>Spéculation excessive</li>
  <li>Questions sur la valeur réelle</li>
  <li>Risques de fraude et de vol</li>
</ul>

<h2>L''Avenir de l''Art Numérique</h2>

<p>Au-delà du battage médiatique, les NFT représentent une évolution intéressante dans la manière dont nous créons, partageons et valorisons l''art à l''ère numérique. La technologie continuera d''évoluer et de s''améliorer.</p>',
  '<p>Explorez l''univers des NFT et leur impact sur l''art numérique et les créateurs.</p>',
  'full_html'
);

-- ============================================================================
-- ARTICLE 5 : Télétravail et Transformation du Travail
-- ============================================================================

INSERT INTO node (nid, vid, type, uuid, langcode)
VALUES (1005, 1005, 'article', gen_random_uuid()::varchar, 'fr');

INSERT INTO node_field_data (
  nid, vid, type, langcode, status, uid, title, created, changed, promote, sticky, default_langcode, revision_translation_affected
)
VALUES (
  1005, 1005, 'article', 'fr', 1, 1,
  'Le Télétravail : Vers un Nouveau Paradigme Professionnel',
  EXTRACT(EPOCH FROM NOW() - INTERVAL '7 days')::integer,
  EXTRACT(EPOCH FROM NOW() - INTERVAL '7 days')::integer,
  1, 0, 1, 1
);

INSERT INTO node__body (
  bundle, deleted, entity_id, revision_id, langcode, delta, body_value, body_summary, body_format
)
VALUES (
  'article', 0, 1005, 1005, 'fr', 0,
  '<p>La pandémie de COVID-19 a accéléré une transformation du monde du travail qui était déjà en cours. Le télétravail, autrefois considéré comme un privilège, est devenu la norme pour des millions de travailleurs.</p>

<h2>Les Avantages du Télétravail</h2>

<h3>Pour les Employés</h3>
<ul>
  <li>Économies de temps et d''argent (transport)</li>
  <li>Meilleur équilibre vie professionnelle / vie personnelle</li>
  <li>Flexibilité dans l''organisation du travail</li>
  <li>Réduction du stress lié aux déplacements</li>
</ul>

<h3>Pour les Entreprises</h3>
<ul>
  <li>Réduction des coûts immobiliers</li>
  <li>Accès à un vivier de talents plus large</li>
  <li>Augmentation de la productivité</li>
  <li>Réduction de l''empreinte carbone</li>
</ul>

<h2>Les Défis à Surmonter</h2>

<p>Le télétravail n''est pas sans inconvénients :</p>

<ul>
  <li>Isolement social et sentiment de déconnexion</li>
  <li>Difficulté à séparer vie professionnelle et personnelle</li>
  <li>Problèmes de communication et de collaboration</li>
  <li>Inégalités d''accès selon les professions</li>
</ul>

<h2>Le Modèle Hybride : L''Avenir du Travail ?</h2>

<p>De nombreuses entreprises adoptent un modèle hybride, combinant télétravail et présence au bureau. Cette approche vise à tirer parti des avantages des deux modèles tout en minimisant leurs inconvénients.</p>

<p>L''avenir du travail sera probablement plus flexible, plus numérique et plus centré sur l''humain.</p>',
  '<p>Analysez les impacts du télétravail sur le monde professionnel et les nouveaux modèles de travail qui émergent.</p>',
  'full_html'
);

-- ============================================================================
-- ARTICLE 6 : Alimentation et Agriculture Urbaine
-- ============================================================================

INSERT INTO node (nid, vid, type, uuid, langcode)
VALUES (1006, 1006, 'article', gen_random_uuid()::varchar, 'fr');

INSERT INTO node_field_data (
  nid, vid, type, langcode, status, uid, title, created, changed, promote, sticky, default_langcode, revision_translation_affected
)
VALUES (
  1006, 1006, 'article', 'fr', 1, 1,
  'L''Agriculture Urbaine : Cultiver la Ville de Demain',
  EXTRACT(EPOCH FROM NOW() - INTERVAL '10 days')::integer,
  EXTRACT(EPOCH FROM NOW() - INTERVAL '10 days')::integer,
  1, 0, 1, 1
);

INSERT INTO node__body (
  bundle, deleted, entity_id, revision_id, langcode, delta, body_value, body_summary, body_format
)
VALUES (
  'article', 0, 1006, 1006, 'fr', 0,
  '<p>Face à l''urbanisation croissante et aux enjeux de sécurité alimentaire, l''agriculture urbaine s''impose comme une solution innovante pour produire localement et durablement.</p>

<h2>Les Différentes Formes d''Agriculture Urbaine</h2>

<h3>Toits Potagers</h3>
<p>Les toits des immeubles sont transformés en espaces de culture productive, offrant également des avantages en termes d''isolation thermique et de gestion des eaux pluviales.</p>

<h3>Fermes Verticales</h3>
<p>Ces installations en intérieur utilisent l''hydroponie et l''éclairage LED pour cultiver des légumes toute l''année, avec une consommation d''eau réduite de 95%.</p>

<h3>Jardins Communautaires</h3>
<p>Ces espaces partagés créent du lien social tout en produisant des aliments frais pour les riverains.</p>

<h3>Aquaponie</h3>
<p>Ce système combine élevage de poissons et culture de plantes dans un écosystème fermé et efficient.</p>

<h2>Les Bénéfices de l''Agriculture Urbaine</h2>

<ul>
  <li><strong>Alimentation locale :</strong> Réduction de l''empreinte carbone du transport</li>
  <li><strong>Fraîcheur :</strong> Produits récoltés à maturité</li>
  <li><strong>Biodiversité :</strong> Création d''habitats pour la faune urbaine</li>
  <li><strong>Lien social :</strong> Activités communautaires et éducatives</li>
  <li><strong>Résilience :</strong> Autonomie alimentaire en cas de crise</li>
</ul>

<h2>Les Défis à Relever</h2>

<p>Malgré son potentiel, l''agriculture urbaine fait face à des obstacles : coûts initiaux élevés, réglementation complexe, compétition pour l''espace urbain, et questions de rentabilité économique.</p>

<p>L''agriculture urbaine ne remplacera pas l''agriculture traditionnelle, mais elle peut contribuer significativement à une alimentation plus durable et locale.</p>',
  '<p>Découvrez comment l''agriculture urbaine révolutionne notre approche de l''alimentation en ville.</p>',
  'full_html'
);

-- ============================================================================
-- ARTICLE 7 : Mobilité Électrique
-- ============================================================================

INSERT INTO node (nid, vid, type, uuid, langcode)
VALUES (1007, 1007, 'article', gen_random_uuid()::varchar, 'fr');

INSERT INTO node_field_data (
  nid, vid, type, langcode, status, uid, title, created, changed, promote, sticky, default_langcode, revision_translation_affected
)
VALUES (
  1007, 1007, 'article', 'fr', 1, 1,
  'Véhicules Électriques : La Révolution de la Mobilité',
  EXTRACT(EPOCH FROM NOW() - INTERVAL '12 days')::integer,
  EXTRACT(EPOCH FROM NOW() - INTERVAL '12 days')::integer,
  1, 0, 1, 1
);

INSERT INTO node__body (
  bundle, deleted, entity_id, revision_id, langcode, delta, body_value, body_summary, body_format
)
VALUES (
  'article', 0, 1007, 1007, 'fr', 0,
  '<p>La mobilité électrique connaît une croissance fulgurante. Les ventes de véhicules électriques explosent et les constructeurs investissent massivement dans cette technologie.</p>

<h2>Les Avantages des Véhicules Électriques</h2>

<h3>Environnement</h3>
<ul>
  <li>Zéro émission locale de CO2</li>
  <li>Réduction de la pollution sonore</li>
  <li>Bilan carbone favorable sur le cycle de vie</li>
</ul>

<h3>Économie</h3>
<ul>
  <li>Coût d''utilisation réduit (électricité vs essence)</li>
  <li>Maintenance simplifiée</li>
  <li>Incitations fiscales et aides à l''achat</li>
</ul>

<h3>Performance</h3>
<ul>
  <li>Accélération instantanée</li>
  <li>Conduite silencieuse</li>
  <li>Centre de gravité bas pour une meilleure tenue de route</li>
</ul>

<h2>Les Défis Technologiques</h2>

<h3>Autonomie et Recharge</h3>
<p>L''autonomie des batteries s''améliore constamment. Les nouvelles générations offrent plus de 500 km d''autonomie. Le réseau de bornes de recharge rapide se densifie.</p>

<h3>Production de Batteries</h3>
<p>L''extraction du lithium et du cobalt pose des questions environnementales et éthiques. Le recyclage des batteries devient un enjeu majeur.</p>

<h3>Réseau Électrique</h3>
<p>L''électrification massive nécessite l''adaptation du réseau électrique et l''augmentation de la production d''électricité renouvelable.</p>

<h2>L''Avenir de la Mobilité</h2>

<p>Au-delà des véhicules particuliers, l''électrification concerne aussi les bus, camions, bateaux et avions. La mobilité de demain sera électrique, partagée et connectée.</p>

<p>Les véhicules électriques sont une pièce essentielle du puzzle de la transition écologique, mais doivent s''accompagner d''une réflexion globale sur nos modes de déplacement.</p>',
  '<p>Explorez la révolution électrique dans le secteur automobile et ses implications pour l''avenir de la mobilité.</p>',
  'full_html'
);

-- ============================================================================
-- ARTICLE 8 : Éducation Numérique
-- ============================================================================

INSERT INTO node (nid, vid, type, uuid, langcode)
VALUES (1008, 1008, 'article', gen_random_uuid()::varchar, 'fr');

INSERT INTO node_field_data (
  nid, vid, type, langcode, status, uid, title, created, changed, promote, sticky, default_langcode, revision_translation_affected
)
VALUES (
  1008, 1008, 'article', 'fr', 1, 1,
  'L''Éducation à l''Ère du Numérique : Défis et Opportunités',
  EXTRACT(EPOCH FROM NOW() - INTERVAL '15 days')::integer,
  EXTRACT(EPOCH FROM NOW() - INTERVAL '15 days')::integer,
  1, 0, 1, 1
);

INSERT INTO node__body (
  bundle, deleted, entity_id, revision_id, langcode, delta, body_value, body_summary, body_format
)
VALUES (
  'article', 0, 1008, 1008, 'fr', 0,
  '<p>Le numérique transforme profondément l''éducation, offrant de nouvelles possibilités d''apprentissage tout en posant des défis inédits aux enseignants et aux institutions.</p>

<h2>Les Innovations Pédagogiques</h2>

<h3>Apprentissage en Ligne (E-learning)</h3>
<p>Les plateformes d''apprentissage en ligne démocratisent l''accès au savoir. Des millions de cours gratuits ou peu coûteux sont disponibles sur des sujets variés.</p>

<h3>Classes Inversées</h3>
<p>Les élèves découvrent les concepts à la maison via des vidéos, et le temps de classe est consacré aux exercices et à l''interaction.</p>

<h3>Gamification</h3>
<p>L''utilisation de mécaniques de jeu rend l''apprentissage plus engageant et motivant, particulièrement pour les jeunes apprenants.</p>

<h3>Réalité Virtuelle et Augmentée</h3>
<p>Ces technologies permettent des expériences d''apprentissage immersives : visiter Rome antique, explorer le corps humain, ou manipuler des molécules en 3D.</p>

<h2>Les Avantages du Numérique Éducatif</h2>

<ul>
  <li><strong>Personnalisation :</strong> Adaptation au rythme de chaque élève</li>
  <li><strong>Accessibilité :</strong> Apprentissage possible partout, à tout moment</li>
  <li><strong>Ressources infinies :</strong> Accès à une quantité illimitée de contenus</li>
  <li><strong>Interactivité :</strong> Engagement actif des apprenants</li>
  <li><strong>Collaboration :</strong> Travail en équipe facilité par les outils numériques</li>
</ul>

<h2>Les Défis à Relever</h2>

<h3>Fracture Numérique</h3>
<p>Tous les élèves n''ont pas un accès égal aux équipements et à la connexion internet, créant de nouvelles inégalités.</p>

<h3>Formation des Enseignants</h3>
<p>Les enseignants doivent être formés aux outils numériques et aux nouvelles pédagogies.</p>

<h3>Surabondance d''Information</h3>
<p>Développer l''esprit critique face à l''information en ligne est essentiel.</p>

<h3>Temps d''Écran</h3>
<p>Il faut trouver un équilibre entre apprentissage numérique et autres formes d''enseignement.</p>

<h2>L''École de Demain</h2>

<p>L''éducation de demain sera hybride, combinant le meilleur du numérique et de l''enseignement traditionnel. L''humain restera au cœur de l''éducation, les technologies n''étant que des outils au service de l''apprentissage.</p>',
  '<p>Découvrez comment le numérique transforme l''éducation et les défis de cette révolution pédagogique.</p>',
  'full_html'
);

-- ============================================================================
-- ARTICLE 9 : Économie Circulaire
-- ============================================================================

INSERT INTO node (nid, vid, type, uuid, langcode)
VALUES (1009, 1009, 'article', gen_random_uuid()::varchar, 'fr');

INSERT INTO node_field_data (
  nid, vid, type, langcode, status, uid, title, created, changed, promote, sticky, default_langcode, revision_translation_affected
)
VALUES (
  1009, 1009, 'article', 'fr', 1, 1,
  'Économie Circulaire : Repenser notre Modèle de Consommation',
  EXTRACT(EPOCH FROM NOW() - INTERVAL '18 days')::integer,
  EXTRACT(EPOCH FROM NOW() - INTERVAL '18 days')::integer,
  1, 0, 1, 1
);

INSERT INTO node__body (
  bundle, deleted, entity_id, revision_id, langcode, delta, body_value, body_summary, body_format
)
VALUES (
  'article', 0, 1009, 1009, 'fr', 0,
  '<p>Face aux limites du modèle linéaire "extraire, fabriquer, jeter", l''économie circulaire propose une alternative durable : réduire, réutiliser, recycler.</p>

<h2>Les Principes de l''Économie Circulaire</h2>

<h3>Éco-conception</h3>
<p>Concevoir des produits durables, réparables et recyclables dès leur création.</p>

<h3>Économie de la Fonctionnalité</h3>
<p>Privilégier l''usage à la possession : location, partage, services plutôt qu''achat.</p>

<h3>Réemploi et Réparation</h3>
<p>Prolonger la durée de vie des produits par la réparation et le don.</p>

<h3>Recyclage et Valorisation</h3>
<p>Transformer les déchets en nouvelles ressources.</p>

<h2>Les Secteurs Concernés</h2>

<h3>Industrie Textile</h3>
<p>L''industrie de la mode adopte progressivement l''économie circulaire : recyclage des vêtements, matériaux durables, location de vêtements.</p>

<h3>Électronique</h3>
<p>Le reconditionnement d''appareils électroniques se développe, réduisant les déchets et rendant la technologie plus accessible.</p>

<h3>Bâtiment</h3>
<p>Réutilisation de matériaux de construction, éco-conception des bâtiments, démontabilité.</p>

<h3>Alimentation</h3>
<p>Lutte contre le gaspillage, compostage, circuits courts, emballages réutilisables.</p>

<h2>Les Bénéfices de l''Économie Circulaire</h2>

<ul>
  <li><strong>Environnementaux :</strong> Réduction des déchets et des émissions de CO2</li>
  <li><strong>Économiques :</strong> Économies de matières premières, création d''emplois locaux</li>
  <li><strong>Sociaux :</strong> Insertion professionnelle, lutte contre la précarité</li>
  <li><strong>Stratégiques :</strong> Réduction de la dépendance aux ressources importées</li>
</ul>

<h2>Les Obstacles et Solutions</h2>

<p>La transition vers l''économie circulaire nécessite :</p>

<ul>
  <li>Un changement de mentalité des consommateurs et entreprises</li>
  <li>Une réglementation favorable (éco-conception obligatoire, interdiction de l''obsolescence programmée)</li>
  <li>Des investissements dans les infrastructures de recyclage</li>
  <li>Une coopération entre acteurs publics et privés</li>
</ul>

<h2>Vers un Modèle Soutenable</h2>

<p>L''économie circulaire n''est pas qu''une contrainte environnementale, c''est une opportunité d''innovation et de création de valeur. Elle dessine un modèle économique plus résilient et respectueux des limites planétaires.</p>',
  '<p>Découvrez les principes de l''économie circulaire et comment elle peut transformer notre modèle de consommation.</p>',
  'full_html'
);

-- ============================================================================
-- ARTICLE 10 : Blockchain et Cryptomonnaies
-- ============================================================================

INSERT INTO node (nid, vid, type, uuid, langcode)
VALUES (1010, 1010, 'article', gen_random_uuid()::varchar, 'fr');

INSERT INTO node_field_data (
  nid, vid, type, langcode, status, uid, title, created, changed, promote, sticky, default_langcode, revision_translation_affected
)
VALUES (
  1010, 1010, 'article', 'fr', 1, 1,
  'Blockchain : Au-delà des Cryptomonnaies',
  EXTRACT(EPOCH FROM NOW() - INTERVAL '20 days')::integer,
  EXTRACT(EPOCH FROM NOW() - INTERVAL '20 days')::integer,
  1, 0, 1, 1
);

INSERT INTO node__body (
  bundle, deleted, entity_id, revision_id, langcode, delta, body_value, body_summary, body_format
)
VALUES (
  'article', 0, 1010, 1010, 'fr', 0,
  '<p>La blockchain est souvent associée aux cryptomonnaies comme le Bitcoin, mais son potentiel va bien au-delà de la finance. Cette technologie de registre distribué pourrait transformer de nombreux secteurs.</p>

<h2>Comprendre la Blockchain</h2>

<p>La blockchain est une base de données distribuée qui stocke des informations de manière transparente, sécurisée et immuable. Chaque bloc contient des transactions et est lié au précédent, formant une chaîne.</p>

<h3>Caractéristiques Clés</h3>
<ul>
  <li><strong>Décentralisation :</strong> Pas d''autorité centrale</li>
  <li><strong>Transparence :</strong> Toutes les transactions sont visibles</li>
  <li><strong>Immutabilité :</strong> Les données ne peuvent pas être modifiées</li>
  <li><strong>Sécurité :</strong> Cryptographie avancée</li>
</ul>

<h2>Applications Au-delà de la Finance</h2>

<h3>Traçabilité des Produits</h3>
<p>La blockchain permet de tracer l''origine et le parcours des produits : alimentation, médicaments, objets de luxe. Lutte contre la contrefaçon et garantie de qualité.</p>

<h3>Santé</h3>
<p>Dossiers médicaux sécurisés et partagés entre professionnels de santé, tout en respectant la vie privée du patient.</p>

<h3>Propriété Intellectuelle</h3>
<p>Enregistrement et protection des droits d''auteur, des brevets et des créations artistiques.</p>

<h3>Vote Électronique</h3>
<p>Systèmes de vote transparents, vérifiables et infalsifiables pour renforcer la démocratie.</p>

<h3>Chaîne Logistique</h3>
<p>Suivi en temps réel des marchandises, réduction des fraudes et optimisation de la supply chain.</p>

<h3>Identité Numérique</h3>
<p>Gestion décentralisée de l''identité, donnant aux individus le contrôle de leurs données personnelles.</p>

<h2>Les Défis de la Blockchain</h2>

<h3>Scalabilité</h3>
<p>Les blockchains publiques comme Bitcoin traitent peu de transactions par seconde. Des solutions comme le Lightning Network tentent de résoudre ce problème.</p>

<h3>Consommation Énergétique</h3>
<p>Le mécanisme de consensus "Proof of Work" consomme énormément d''énergie. Des alternatives comme le "Proof of Stake" sont plus écologiques.</p>

<h3>Réglementation</h3>
<p>L''absence de cadre juridique clair freine l''adoption de la technologie par les entreprises et institutions.</p>

<h3>Complexité Technique</h3>
<p>La technologie reste difficile à comprendre et à implémenter pour le grand public et de nombreuses entreprises.</p>

<h2>L''Avenir de la Blockchain</h2>

<p>La blockchain est une technologie jeune et en pleine évolution. Si elle ne résoudra pas tous les problèmes, elle offre des solutions innovantes pour de nombreux cas d''usage nécessitant transparence, traçabilité et décentralisation.</p>

<p>Les prochaines années verront probablement une adoption accrue dans des secteurs clés, ainsi que l''émergence de nouvelles applications que nous n''imaginons pas encore.</p>',
  '<p>Explorez les applications de la blockchain au-delà des cryptomonnaies et son potentiel disruptif.</p>',
  'full_html'
);

-- ============================================================================
-- ARTICLE 11 : Santé Mentale et Bien-être
-- ============================================================================

INSERT INTO node (nid, vid, type, uuid, langcode)
VALUES (1011, 1011, 'article', gen_random_uuid()::varchar, 'fr');

INSERT INTO node_field_data (
  nid, vid, type, langcode, status, uid, title, created, changed, promote, sticky, default_langcode, revision_translation_affected
)
VALUES (
  1011, 1011, 'article', 'fr', 1, 1,
  'Santé Mentale : Briser les Tabous et Prendre Soin de Soi',
  EXTRACT(EPOCH FROM NOW() - INTERVAL '22 days')::integer,
  EXTRACT(EPOCH FROM NOW() - INTERVAL '22 days')::integer,
  1, 1, 1, 1
);

INSERT INTO node__body (
  bundle, deleted, entity_id, revision_id, langcode, delta, body_value, body_summary, body_format
)
VALUES (
  'article', 0, 1011, 1011, 'fr', 0,
  '<p>La santé mentale est aussi importante que la santé physique, pourtant elle reste entourée de stigmates. Il est temps de briser les tabous et de normaliser le fait de prendre soin de sa santé mentale.</p>

<h2>Comprendre la Santé Mentale</h2>

<p>La santé mentale englobe notre bien-être émotionnel, psychologique et social. Elle affecte notre façon de penser, de ressentir et d''agir.</p>

<h3>Signes à Surveiller</h3>
<ul>
  <li>Changements d''humeur importants</li>
  <li>Retrait social</li>
  <li>Troubles du sommeil</li>
  <li>Changements d''appétit</li>
  <li>Difficultés de concentration</li>
  <li>Fatigue persistante</li>
  <li>Sentiments de désespoir</li>
</ul>

<h2>Les Troubles Mentaux Courants</h2>

<h3>Dépression</h3>
<p>La dépression touche plus de 300 millions de personnes dans le monde. Ce n''est pas une faiblesse, mais une maladie qui se soigne.</p>

<h3>Anxiété</h3>
<p>Les troubles anxieux se manifestent par des inquiétudes excessives et persistantes qui perturbent le quotidien.</p>

<h3>Burn-out</h3>
<p>L''épuisement professionnel résulte d''un stress chronique au travail non géré.</p>

<h2>Prendre Soin de sa Santé Mentale</h2>

<h3>Au Quotidien</h3>
<ul>
  <li><strong>Activité physique :</strong> L''exercice libère des endorphines</li>
  <li><strong>Sommeil :</strong> 7-9 heures par nuit</li>
  <li><strong>Alimentation :</strong> Une nutrition équilibrée impacte l''humeur</li>
  <li><strong>Relations sociales :</strong> Maintenir des liens avec ses proches</li>
  <li><strong>Loisirs :</strong> Prendre du temps pour soi</li>
  <li><strong>Méditation :</strong> Pratiques de pleine conscience</li>
</ul>

<h3>Quand Demander de l''Aide</h3>
<p>Il est important de consulter un professionnel si :</p>
<ul>
  <li>Les symptômes persistent plus de deux semaines</li>
  <li>Ils interfèrent avec le quotidien</li>
  <li>On a des pensées d''auto-destruction</li>
</ul>

<h2>Les Ressources Disponibles</h2>

<ul>
  <li><strong>Psychologues et psychiatres :</strong> Professionnels de la santé mentale</li>
  <li><strong>Lignes d''écoute :</strong> Soutien anonyme et immédiat</li>
  <li><strong>Applications :</strong> Outils de méditation et de gestion du stress</li>
  <li><strong>Groupes de soutien :</strong> Partage d''expériences</li>
</ul>

<h2>Briser les Stigmates</h2>

<p>Parler de santé mentale ne devrait pas être tabou. Plus nous en parlons ouvertement, plus nous normalisons le fait de demander de l''aide et de prendre soin de notre bien-être psychologique.</p>

<p>Prendre soin de sa santé mentale n''est pas un luxe, c''est une nécessité. Vous n''êtes pas seul, et il n''y a aucune honte à demander de l''aide.</p>',
  '<p>Un guide complet sur l''importance de la santé mentale et comment en prendre soin au quotidien.</p>',
  'full_html'
);

-- ============================================================================
-- ARTICLE 12 : Espace et Exploration
-- ============================================================================

INSERT INTO node (nid, vid, type, uuid, langcode)
VALUES (1012, 1012, 'article', gen_random_uuid()::varchar, 'fr');

INSERT INTO node_field_data (
  nid, vid, type, langcode, status, uid, title, created, changed, promote, sticky, default_langcode, revision_translation_affected
)
VALUES (
  1012, 1012, 'article', 'fr', 1, 1,
  'La Nouvelle Ère de l''Exploration Spatiale',
  EXTRACT(EPOCH FROM NOW() - INTERVAL '25 days')::integer,
  EXTRACT(EPOCH FROM NOW() - INTERVAL '25 days')::integer,
  1, 1, 1, 1
);

INSERT INTO node__body (
  bundle, deleted, entity_id, revision_id, langcode, delta, body_value, body_summary, body_format
)
VALUES (
  'article', 0, 1012, 1012, 'fr', 0,
  '<p>Nous vivons une nouvelle ère dorée de l''exploration spatiale. Des entreprises privées aux agences gouvernementales, l''espace n''a jamais été aussi accessible.</p>

<h2>Le Retour sur la Lune</h2>

<p>Le programme Artemis de la NASA vise à établir une présence humaine durable sur la Lune d''ici 2030. Cette fois, l''objectif n''est pas seulement d''y aller, mais d''y rester.</p>

<h3>Pourquoi Retourner sur la Lune ?</h3>
<ul>
  <li>Base avancée pour l''exploration de Mars</li>
  <li>Exploitation de ressources (eau, métaux rares)</li>
  <li>Recherche scientifique</li>
  <li>Démonstration technologique</li>
</ul>

<h2>Mars : La Prochaine Frontière</h2>

<p>Mars fascine l''humanité depuis des siècles. SpaceX, avec son vaisseau Starship, ambitionne d''envoyer les premiers humains sur la planète rouge dans les années 2030.</p>

<h3>Les Défis de Mars</h3>
<ul>
  <li><strong>Distance :</strong> 6-9 mois de voyage</li>
  <li><strong>Radiations :</strong> Exposition dangereuse pendant le voyage</li>
  <li><strong>Gravité :</strong> 38% de celle de la Terre</li>
  <li><strong>Atmosphère :</strong> Très fine et irrespirable</li>
  <li><strong>Températures :</strong> -63°C en moyenne</li>
</ul>

<h2>L''Essor du Spatial Privé</h2>

<h3>SpaceX</h3>
<p>Révolutionné l''industrie avec ses fusées réutilisables, réduisant considérablement les coûts de lancement.</p>

<h3>Blue Origin</h3>
<p>Développe des technologies pour rendre l''accès à l''espace plus abordable et démocratique.</p>

<h3>Autres Acteurs</h3>
<p>De nombreuses startups émergent : tourisme spatial, satellites, exploitation minière d''astéroïdes.</p>

<h2>Les Technologies Clés</h2>

<h3>Fusées Réutilisables</h3>
<p>Réduction drastique des coûts en récupérant et réutilisant les boosters.</p>

<h3>Production In-Situ</h3>
<p>Fabriquer du carburant, de l''oxygène et des matériaux de construction sur place à partir de ressources locales.</p>

<h3>Habitats Spatiaux</h3>
<p>Développement de structures capables de protéger les humains des radiations et de créer un environnement viable.</p>

<h3>Propulsion Avancée</h3>
<p>Moteurs ioniques, propulsion nucléaire pour des voyages plus rapides.</p>

<h2>Les Bénéfices pour la Terre</h2>

<p>L''exploration spatiale n''est pas qu''une aventure lointaine, elle a des retombées concrètes :</p>

<ul>
  <li>Technologies médicales (IRM, purification de l''eau)</li>
  <li>Matériaux innovants</li>
  <li>Télécommunications satellites</li>
  <li>Observation de la Terre et surveillance du climat</li>
  <li>Inspiration et éducation</li>
</ul>

<h2>Questions Éthiques</h2>

<p>L''exploration spatiale soulève des questions importantes :</p>

<ul>
  <li>Qui possède l''espace ?</li>
  <li>Comment éviter la militarisation ?</li>
  <li>Protection planétaire : ne pas contaminer d''autres mondes</li>
  <li>Équité : l''espace doit-il bénéficier à toute l''humanité ?</li>
</ul>

<h2>L''Avenir de l''Humanité Spatiale</h2>

<p>Nous ne sommes qu''au début de notre aventure spatiale. Dans quelques décennies, des humains vivront peut-être de manière permanente sur la Lune, Mars et au-delà. L''humanité devient une espèce multiplanétaire.</p>

<p>L''exploration spatiale représente l''une des plus grandes aventures de l''humanité, repoussant les limites de nos connaissances et de nos capacités.</p>',
  '<p>Découvrez les projets ambitieux de l''exploration spatiale moderne et l''avenir de l''humanité dans l''espace.</p>',
  'full_html'
);

-- ============================================================================
-- Vérification finale
-- ============================================================================

-- Compter le nombre d'articles insérés
SELECT COUNT(*) as total_articles FROM node WHERE type = 'article' AND nid >= 1001;

-- Afficher la liste des articles
SELECT nid, title, created, status
FROM node_field_data
WHERE type = 'article' AND nid >= 1001
ORDER BY created DESC;

-- ============================================================================
-- FIN DU SCRIPT
-- ============================================================================

-- NOTES :
-- 1. Ce script insère 12 articles complets avec du contenu HTML riche
-- 2. Les articles sont datés de manière échelonnée dans le temps
-- 3. Certains articles sont marqués comme "sticky" (épinglés)
-- 4. Tous les articles sont publiés (status = 1) et promus en page d'accueil (promote = 1)
-- 5. Le format de texte utilisé est 'full_html' pour permettre le HTML complet
--
-- EXÉCUTION :
-- docker exec -i drupal-postgres psql -U drupal -d drupal < scripts/sql/insert_sample_articles.sql
