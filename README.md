# loveboard

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.









# build

## steps
### android
flutter --no-color build apk
## issues

### android

#### flutter flutter_inappwebview minSdkVersion 16 cannot be smaller than version 17
add minSdkVersion 17 to build.gradle > android > defaultConfig
change all AndroidManifest.xml targetSdkVersion property to android:targetSdkVersion="17"
#### flutter Manifest versionCode not found
delete android and build folders
run flutter create .