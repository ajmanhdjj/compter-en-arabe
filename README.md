# Compter en Arabe
Une application mobile Flutter pour apprendre à compter en arabe de 1 à 100.

## Prérequis
- Flutter SDK (>= 3.0.0)
- Dart (>= 2.17.0)
- Android Studio ou Xcode (pour iOS)
- Un émulateur ou appareil physique

## Installation
1. Clonez le dépôt : git clone https://github.com/ajmanhdjj/compter-en-arabe.git
2. Naviguez dans le dossier : cd compter-en-arabe
3. Installez les dépendances : flutter pub get
4. Configurez les assets :
    * Placez les fichiers audio (1.mp3 à 100.mp3) dans assets/sounds/.
    * Ajoutez la police ArabicFont.ttf dans fonts/.
5. Lancez l’app : flutter run

## Utilisation
- Cliquez sur "Start" pour accéder à l’écran d’apprentissage.
- Entrez un nombre (1-100) pour voir son nom en arabe, sa translittération et son équivalent en français.
- Cliquez sur une carte dans la grille pour entendre la prononciation et voir les détails (nom arabe, translittération, nom français).
- Animations fluides et interface adaptée aux petits écrans.

## Déploiement
- Android : `flutter build apk --release`
- iOS : `flutter build ios --release`
