# FinMedica - APP

An app create with Flutter.

## Getting started

Clone this repo, then:

```bash
cd app
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter pub run intl_utils:generate
```
    
## How to run

In this app exist 4 main enviroments:

**Dev**:
```bash
flutter run --flavor dev -t lib/main_dev.dart  
```
**QA**:
```bash
flutter run --flavor qa -t lib/main_qa.dart  
```
**Staging**:
```bash
flutter run --flavor staging -t lib/main_staging.dart  
```
**Production**:
```bash
flutter run --flavor production -t lib/main.dart  
```

##  How to make a release build

### For Android

You need to request the keystore and his credentials.

Update the properties in the file `android/gradle.properties`:
- STORE_FILE: location and name of the keystore
- KEY_ALIAS: the key alias inside the keystore
- STORE_PASSWORD: password of the keystore
- KEY_PASSWORD: password of the key

Then you can run:

**QA**
```bash
flutter build appbundle --flavor qa -t lib/main_qa.dart
```
**Staging**
```bash
flutter build appbundle --flavor staging -t lib/main_staging.dart
```
**Production**
```bash
flutter build appbundle -—flavor production
```
For more information see the [documentation](https://docs.flutter.dev/deployment/android).

### For iOS
You will need the profile or an account that can create a build for App Store.

Then you can run:
**QA**
```bash
flutter build ipa --flavor qa -t lib/main_qa.dart
```
**Staging**
```bash
flutter build ipa --flavor staging -t lib/main_staging.dart
```
**Production**
```bash
flutter build ipa --flavor production
```
For more information see the [documentation](https://docs.flutter.dev/deployment/ios).

## To change the app icon

Update the file `pubspec.yaml` in the section `flutter_icons`:

```
flutter pub run flutter_launcher_icons
```