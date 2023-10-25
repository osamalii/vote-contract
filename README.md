
# Système de Vote

Ce référentiel contient le code source et la documentation du projet "Système de Vote". Le projet a été réalisé dans le cadre d'une évaluation académique et a pour objectif de créer un contrat intelligent (smart contract) pour gérer un processus de vote numérique. Voici un aperçu de ce projet.

## Description du Projet

Le projet "Système de Vote" vise à créer un contrat intelligent Ethereum permettant de gérer un processus de vote pour une petite organisation. Le contrat offre les fonctionnalités suivantes :

- **Inscription des Électeurs** : L'administrateur peut inscrire des électeurs en utilisant leurs adresses Ethereum, formant ainsi une liste blanche d'électeurs autorisés à participer au vote.

- **Enregistrement des Propositions** : Une session d'enregistrement des propositions est ouverte, au cours de laquelle les électeurs inscrits peuvent soumettre leurs propositions.

- **Session de Vote** : Après la clôture de la session d'enregistrement des propositions, une session de vote est lancée. Les électeurs inscrits peuvent voter pour leurs propositions préférées.

- **Détermination du Gagnant** : Le système détermine la proposition gagnante en comptabilisant les votes. La proposition avec le plus de votes l'emporte.

- **Transparence** : Le système garantit la transparence en permettant à tous les participants de vérifier les détails de la proposition gagnante.

## Structure du Code

Le code du projet est organisé comme suit :

- Le contrat intelligent principal est nommé "Voting.sol" et implémente les fonctionnalités décrites ci-dessus.

- Le contrat intelligent utilise des structures de données pour gérer les électeurs et les propositions, ainsi qu'une énumération pour suivre l'état du vote.

- Le contrat intelligent importe la bibliothèque "Ownable" d'OpenZeppelin pour gérer les droits d'administration.

- Des événements sont définis pour informer les parties prenantes des actions importantes effectuées sur le contrat.

## Fonctionnalités Additionnelles

Dans le cadre de l'évaluation, deux fonctionnalités additionnelles ont été implémentées, mais elles ne sont pas détaillées dans ce README.

## Tests Automatisés

Des tests automatisés ont été créés pour garantir le bon fonctionnement du contrat intelligent. Ces tests sont disponibles dans le répertoire "tests".

## Développement de la Dapp

Le développement d'une interface utilisateur (Dapp) permettant d'interagir avec le contrat intelligent est requis, mais elle n'est pas incluse dans ce référentiel.

## Bonus : Documentation

La documentation complète du projet, y compris les instructions pour le déploiement, l'utilisation de la Dapp et une vidéo de démonstration, peut être trouvée dans un déploiement public (Heroku / GhPages, AWS, Vercel, ...). Le lien vers cette documentation sera fourni ultérieurement.


