# drupal-mania

Pile applicative Drupal + postgres déployée dans des conteneurs Docker

## Description

Ce projet est géré avec historisation Git pour permettre l'itération continue avec Claude.

## Type de projet

**Type:** code

## Repository

```
https://github.com/aboigues/drupal-mania.git
```

## Structure

```
drupal-mania/
├── README.md                  # Ce fichier
├── .claude/                   # Configuration et instructions pour Claude
│   ├── INSTRUCTIONS.md        # Instructions complètes pour Claude
│   ├── QUICKSTART.md          # Démarrage rapide
│   └── CONTEXT.md             # Contexte et historique du projet
├── docs/                      # Documentation
├── src/                       # Code source
├── data/                      # Données
└── tests/                     # Tests
```

## Démarrage

1. Cloner le repository
2. Lire la documentation dans `docs/`
3. Consulter `.claude/INSTRUCTIONS.md` pour comprendre le workflow

## Workflow avec Claude

### Nouvelle session

1. Claude recherche le contexte avec `conversation_search`
2. Clone le repo
3. Lit `.claude/INSTRUCTIONS.md`
4. Itère sur le code existant
5. Commit et push les modifications

### Commandes Git

```bash
# Cloner
git clone https://TOKEN@github.com/aboigues/drupal-mania.git

# Voir l'historique
git log --oneline

# Pousser les modifications
git add .
git commit -m "Description"
git push origin main
```

## Auteur

**Utilisateur:** aboigues
**Créé avec:** Claude (Anthropic)
**Date:** 2025-10-27
