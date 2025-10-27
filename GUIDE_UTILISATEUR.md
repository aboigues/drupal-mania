# Guide Utilisateur - drupal-mania

## Vue d'ensemble

Ce projet est configuré pour permettre une collaboration continue avec Claude à travers plusieurs sessions, avec historisation complète sur GitHub.

## Structure du projet

```
drupal-mania/
├── README.md                  # Documentation principale
├── GUIDE_UTILISATEUR.md       # Ce fichier
├── PUSH_TO_GITHUB.sh          # Script de push initial
├── .claude/                   # Configuration pour Claude
│   ├── INSTRUCTIONS.md        # Instructions complètes
│   ├── QUICKSTART.md          # Démarrage rapide
│   └── CONTEXT.md             # Contexte et historique
├── docs/                      # Documentation
├── src/                       # Code source
├── data/                      # Données
└── tests/                     # Tests
```

## Première utilisation

### 1. Créer le repository sur GitHub

Allez sur https://github.com/new et créez un repository nommé: **drupal-mania**

### 2. Obtenir un token GitHub

1. Allez sur https://github.com/settings/tokens
2. "Generate new token" → "Generate new token (classic)"
3. Nom: `Claude drupal-mania`
4. Cochez: **repo** (Full control of private repositories)
5. Expiration: **No expiration**
6. Générez et copiez le token (format: `ghp_XXXX...`)

### 3. Pousser le projet sur GitHub

```bash
./PUSH_TO_GITHUB.sh <votre-token>
```

Ou manuellement:

```bash
git add .
git commit -m "Initial commit"
git remote add origin https://<TOKEN>@github.com/aboigues/drupal-mania.git
git branch -M main
git push -u origin main
```

## Travailler avec Claude

### À chaque nouvelle session

Donnez simplement le token à Claude et demandez-lui de travailler sur le projet:

```
Claude, travaille sur le projet drupal-mania.
Voici le token: ghp_XXXX...
```

Claude va:
1. Rechercher le contexte dans vos conversations passées
2. Cloner le repository
3. Lire `.claude/INSTRUCTIONS.md`
4. Consulter `.claude/CONTEXT.md`
5. Voir l'historique Git
6. Effectuer les modifications demandées
7. Mettre à jour CONTEXT.md
8. Committer et pousser

### Consulter l'historique

Sur GitHub: https://github.com/aboigues/drupal-mania/commits/main

Localement:
```bash
git log --oneline
git log --graph --all
```

### Voir les changements

```bash
git diff
git show <commit-hash>
```

## Commandes utiles

```bash
# Cloner
git clone https://github.com/aboigues/drupal-mania.git

# Mettre à jour
git pull

# Voir le statut
git status

# Voir l'historique
git log --oneline -10
```

## Fichiers importants pour Claude

- `.claude/INSTRUCTIONS.md` - Instructions complètes pour Claude
- `.claude/QUICKSTART.md` - Démarrage rapide
- `.claude/CONTEXT.md` - Contexte et historique des sessions

Ces fichiers permettent à Claude de retrouver rapidement le contexte et de continuer le travail de session en session.

## Bonnes pratiques

1. **Messages de commit clairs**: Décrivez ce qui a été fait
2. **Mise à jour de CONTEXT.md**: Documentez les changements importants
3. **Branches**: Utilisez des branches pour les fonctionnalités majeures
4. **Pull requests**: Pour les modifications importantes
5. **Documentation**: Maintenez la documentation à jour

## Support

**Repository**: https://github.com/aboigues/drupal-mania
**Type**: code
**Créé**: 2025-10-27

---

Pour toute question, consultez `.claude/INSTRUCTIONS.md` ou demandez à Claude.
