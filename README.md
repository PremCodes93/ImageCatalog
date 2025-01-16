# Image Listing App

A Flutter app that displays a list of images with features like infinite scrolling, error handling, and smooth animations

## Prerequisites

#### Flutter Version:
Ensure that you have Flutter version 3.27.2 installed.

#### Run Pub Get:
```bash
pub get
```

#### Generate Build Files:
This project uses build_runner for code generation. Run the following command to build all generated files:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Environment Configuration:
The BaseUrl and accessToken are not stored in the repository. They need to be passed during build time via Dart defines.

Create a JSON file with environment-specific values (e.g., key_environment.json) and pass it during build/run.

```bash
--dart-define-from-file=key_environment.json
```
