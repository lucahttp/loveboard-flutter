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
C:\src\flutter\bin\flutter.bat --no-color build apk

## tutorials
https://medium.com/flutter-community/create-custom-radio-input-in-flutter-8d94a273d374
## issues

### android

#### flutter flutter_inappwebview minSdkVersion 16 cannot be smaller than version 17
add minSdkVersion 17 to build.gradle > android > defaultConfig
change all AndroidManifest.xml targetSdkVersion property to android:targetSdkVersion="17"
#### flutter Manifest versionCode not found
delete android and build folders
run flutter create .

#### internet images
In the AndroidManifest.xml file located at android/app/src/main you need to add this permission inside the manifest tag.

https://stackoverflow.com/questions/62908202/getting-internet-permission-in-flutter-app
<uses-permission android:name="android.permission.INTERNET" />
https://stackoverflow.com/questions/12778168/access-network-state-permission-on-android-ics/40458189#40458189
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>

####
    // ERROR Exception has occurred. | _CastError (Null check operator used on a null value)
