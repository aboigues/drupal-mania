#!/bin/bash

# Script pour pousser le projet sur GitHub
# Usage: ./PUSH_TO_GITHUB.sh <votre-token-github>

if [ -z "$1" ]; then
    echo "Usage: ./PUSH_TO_GITHUB.sh <github-token>"
    echo ""
    echo "Pour créer un token:"
    echo "1. https://github.com/settings/tokens"
    echo "2. Generate new token (classic)"
    echo "3. Cocher: repo"
    echo "4. Copier le token"
    exit 1
fi

TOKEN=$1

# Vérifier si le repo existe sur GitHub
echo "Assurez-vous d'avoir créé le repo sur GitHub:"
echo "https://github.com/aboigues/drupal-mania"
echo ""
read -p "Le repo existe sur GitHub? (y/n): " CONFIRM

if [ "$CONFIRM" != "y" ]; then
    echo "Créez d'abord le repo sur GitHub puis relancez ce script"
    exit 1
fi

# Ajouter tous les fichiers
git add .

# Premier commit
git commit -m "Initial commit: Project initialization"

# Ajouter le remote
git remote add origin https://$TOKEN@github.com/aboigues/drupal-mania.git

# Créer la branche main si elle n'existe pas
git branch -M main

# Pousser
git push -u origin main

echo ""
echo "✓ Projet poussé sur GitHub!"
echo "✓ Repository: https://github.com/aboigues/drupal-mania"
