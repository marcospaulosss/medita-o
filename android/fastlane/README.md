fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android test

```sh
[bundle exec] fastlane android test
```

Runs all the tests

### android beta

```sh
[bundle exec] fastlane android beta
```

Submit a new Beta Build to Crashlytics Beta

### android deploy

```sh
[bundle exec] fastlane android deploy
```

Deploy a new version to the Google Play

### android internal_test

```sh
[bundle exec] fastlane android internal_test
```

Deploy a new version to the Google Play Internal Test

### android firebase

```sh
[bundle exec] fastlane android firebase
```

Upload dev app to Firebase App Distribution

### android firebase_prod

```sh
[bundle exec] fastlane android firebase_prod
```

Upload dev app to Firebase App Distribution

### android upload_android_production_app

```sh
[bundle exec] fastlane android upload_android_production_app
```

Upload production app to Play Store

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
