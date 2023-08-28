# cinco_minutos_meditacao

A new Flutter project de meditação.

## Getting Started

Este projeto é um ponto de partida para um aplicativo Flutter.

Alguns recursos para você começar se este for seu primeiro projeto Flutter:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

Para obter ajuda para começar com o desenvolvimento do Flutter, veja o
[documentação online](https://docs.flutter.dev/), que oferece tutoriais,
amostras, orientação sobre desenvolvimento móvel e uma referência completa da API.

## Configuração do multi ambiente dev e prod

### dependencias
    - flutter pub add flutter_flavorizr

### Configuração
- Adicionar as linhas flavorizr no pubspec.yaml na raiz do projeto
```yaml
flavorizr:
  app:
    android:
      flavorDimensions: "flavor-type"

  flavors:
    dev:
      app:
        name: "Dev"
      android:
        applicationId: "eumedito.org.cinco_minutos.dev"
        icon: "assets/images/icon_app_android.jpeg"
        firebase:
          config: "core/firebase/dev/google-services.json"

      ios:
        bundleId: "eumedito.org.cincoMinutos.dev"
        buildSettings:
          # Development Team is visible in the apple developer portal
          DEVELOPMENT_TEAM: cincoMinutos-dev
          PROVISIONING_PROFILE_SPECIFIER: "Dev-ProvisioningProfile"
        icon: "assets/images/icon_app_ios.jpeg"
        firebase:
          config: "core/firebase/dev/GoogleService-Info.plist"

    prod:
      app:
        name: "5 Minutos"
      android:
        applicationId: "eumedito.org.cinco_minutos"
        icon: "assets/images/icon_app_android.jpeg"
        firebase:
          config: "core/firebase/prod/google-services.json"

      ios:
        bundleId: "eumedito.org.cincoMinutos"
        buildSettings:
          # Development Team is visible in the apple developer portal
          DEVELOPMENT_TEAM: cincoMinutos-prod
          PROVISIONING_PROFILE_SPECIFIER: "Prod-ProvisioningProfile"
        icon: "assets/images/icon_app_ios.jpeg"
        firebase:
          config: "core/firebase/prod/GoogleService-Info.plist"
```

### Gerando os Flavors de dev e produção
```shell
flutter pub run flutter_flavorizr
```

## Configuração do Firebase
- Ative o multidex no arquivo app/build.gradle
```gradle
    minSdkVersion 21
    multiDexEnabled true
```

- crie o projeto no firebase com a chave SHA1 do seu projeto
```shell
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
```
- importe o arquivo google-services.json para o projeto utilizando o flavorizr


## Configuração de variáveis sendo executadas em tempo de execução do flutter pelo arquivo .env
- dependencias
    - flutter_dotenv: ^5.0.2
  
arquivo .env.dev para ambiente de desenvolvimento
arquivo .env para ambiente de desenvolvimento

## Aplicação configurado para utilizar monitoramento via firebase utilizando as seguintes dependencias
- firebase_analytics: ^8.3.1
- firebase_crashlytics: ^2.2.3

## Configurando fastlane
https://docs.flutter.dev/deployment/cd#fastlane
```shell
brew install fastlane
```

## Configuração da splash screen do projeto
- dev_dependencies
    - flutter_native_splash: ^1.2.1

### Introdução
Utilizamos o flutter_native_splash para gerar a splash screen nativa do projeto, para isso é necessário configurar o arquivo flutter_native_splash.yaml na raiz do projeto.

Adicionar imagem na pasta assets/images/splash_screen.png
Executar o comando:

```shell
flutter pub run flutter_native_splash:create
```


# Resolução de problemas com cocopods e flutter
```shell
flutter clean
rm -rf ios/Pods
rm ios/Podfile.lock
flutter pub get
cd ios
pod deintegrate
pod install
cd ..
```