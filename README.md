# Image Palette

A Flutter package that allows you to generate a color palette from an image and use it in your Flutter app.

## Features

- Generates a color palette from an `Image` widget
- Allows the user to select a color from the palette
- Provides a customizable color picker dialog

## Installation

1. Add the package to your `pubspec.yaml` file:

   ```yaml
   dependencies:
     image_palette: ^0.0.1
   ```

2. Run `flutter pub get` to install the package.

## Usage

Import the package in your Dart file:

   ```dart
   import 'package:image_palette/image_palette.dart';
   ```

Use the `ImagePalette` widget in your app:

   ```dart
   ImagePalette(
     onValueChanged: (color) {
       // Handle the selected color
       print('Selected color: $color');
     },
     image: Image.network('https://example.com/image.jpg'),
   )
   ```

   The `onValueChanged` callback is called whenever the user selects a color from the palette.

## Contributing

If you find any issues or have ideas for new features, please feel free to open a GitHub issue or submit a pull request.

## License

This package is licensed under the [MIT License](LICENSE).
