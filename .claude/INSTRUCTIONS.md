# INSTRUCTIONS POUR CLAUDE - drupal-mania

## Contexte du projet

**Projet:** drupal-mania
**Type:** code
**Description:** Pile applicative Drupal + postgres déployée dans des conteneurs Docker
**Utilisateur:** aboigues
**Repository:** https://github.com/aboigues/drupal-mania.git

## Objectif

[Décrire l'objectif principal du projet]

## Règles importantes

1. **Historisation obligatoire**: Tous les livrables doivent être versionnés sur GitHub
2. **Itération**: Chaque session doit partir de la dernière version sur GitHub
3. **Documentation**: Maintenir la documentation à jour
4. **Tests**: [Ajouter les règles de tests si applicable]

## Workflow à suivre à chaque session

### 1. Retrouver le contexte

```bash
# Rechercher les conversations précédentes
conversation_search: "drupal-mania"

# Ou voir les sessions récentes
recent_chats: n=5
```

### 2. Cloner le repository

```bash
cd /home/claude
git clone https://TOKEN@github.com/aboigues/drupal-mania.git
cd drupal-mania
```

### 3. Analyser l'état actuel

```bash
# Voir l'historique
git log --oneline -10

# Voir la structure
ls -la

# Lire les derniers changements
git log -1 --stat

# Lire le contexte
cat .claude/CONTEXT.md
```

### 4. Effectuer les modifications

[Décrire les étapes spécifiques au projet]

### 5. Mettre à jour le contexte

```bash
# Mettre à jour CONTEXT.md avec les changements importants
echo "## Session $(date +%Y-%m-%d)" >> .claude/CONTEXT.md
echo "- [Description des changements]" >> .claude/CONTEXT.md
```

### 6. Committer et pousser

```bash
git add .
git commit -m "Session $(date +%Y-%m-%d): [Description]"
git push origin main
```

### 7. Mettre à disposition

```bash
# Copier dans outputs pour téléchargement
cp -r . /mnt/user-data/outputs/drupal-mania/
```

## Structure du projet

```
drupal-mania/
├── README.md                  # Documentation principale
├── .claude/                   # Configuration Claude
│   ├── INSTRUCTIONS.md        # Ce fichier
│   ├── QUICKSTART.md          # Démarrage rapide
│   └── CONTEXT.md             # Historique et contexte
├── docs/                      # Documentation
├── src/                       # Code source
├── data/                      # Données
└── tests/                     # Tests
```

## Technologies utilisées

[Lister les technologies, frameworks, outils]

## Commandes essentielles

### Git

```bash
# Cloner
git clone https://TOKEN@github.com/aboigues/drupal-mania.git

# Statut
git status

# Historique
git log --oneline -20
git log --graph --oneline --all

# Différences
git diff

# Pousser
git add .
git commit -m "Message"
git push origin main
```

### Projet spécifiques

[Ajouter les commandes spécifiques au projet]

## Checklist avant chaque push

- [ ] Le code fonctionne
- [ ] Les tests passent (si applicable)
- [ ] La documentation est à jour
- [ ] CONTEXT.md est mis à jour
- [ ] Le message de commit est clair
- [ ] Aucun secret/token dans le code

## Messages de commit standards

```
# Ajout de fonctionnalité
"feat: [description]"
"add: [élément ajouté]"

# Modifications
"update: [élément modifié]"
"improve: [amélioration]"

# Corrections
"fix: [problème corrigé]"
"bugfix: [bug corrigé]"

# Documentation
"docs: [modification documentation]"

# Refactoring
"refactor: [restructuration]"

# Sessions
"session YYYY-MM-DD: [résumé]"
```

## Comment retrouver ce document

```bash
# Méthode 1: Rechercher dans conversations
conversation_search: "instructions drupal-mania"

# Méthode 2: Cloner et lire
git clone https://TOKEN@github.com/aboigues/drupal-mania.git
cat drupal-mania/.claude/INSTRUCTIONS.md

# Méthode 3: Chercher sur Drive (si synchronisé)
google_drive_search: "INSTRUCTIONS drupal-mania"
```

## Scénarios d'utilisation

### Scénario 1: Ajouter une fonctionnalité

1. Cloner le repo
2. Créer la fonctionnalité
3. Tester
4. Documenter
5. Mettre à jour CONTEXT.md
6. Committer: "feat: [description]"
7. Pousser

### Scénario 2: Corriger un bug

1. Cloner le repo
2. Identifier le problème
3. Corriger
4. Tester
5. Committer: "fix: [description]"
6. Pousser

### Scénario 3: Refactoring

1. Cloner le repo
2. Restructurer le code
3. S'assurer que tout fonctionne
4. Mettre à jour la documentation
5. Committer: "refactor: [description]"
6. Pousser

## Contact et support

**Utilisateur:** aboigues
**Projet:** drupal-mania

---

**Document créé:** $(date +%Y-%m-%d)
**Version:** 1.0
