import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

/// A Flutter widget that displays an image and a color palette based on the image.
class ImagePalette extends StatefulWidget {
  /// Creates a new instance of the [ImagePalette] widget.
  ///
  /// The [onValueChanged] callback is called whenever the user selects a color from the palette.
  ///
  /// The [image] parameter is an optional [Image] widget that will be used to generate the color palette.
  const ImagePalette({super.key, required this.onValueChanged, this.image});

  /// A callback that is called whenever the user selects a color from the palette.
  final ValueChanged<Color> onValueChanged;

  /// An optional [Image] widget that will be used to generate the color palette.
  final Image? image;

  @override
  State<ImagePalette> createState() => _ImagePaletteState();
}

class _ImagePaletteState extends State<ImagePalette> {
  Color _color = Colors.black;

  @override
  void initState() {
    super.initState();
    if (widget.image != null) {
      genPaletteFromImage(widget.image);
    }
  }

  /// A list of base colors that will be used in the color palette.
  List<Color> baseColor = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.black,
    Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(48.0),
      onTap: () => showColorPicker(),
      child: Container(
        width: 48,
        height: 48,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: _color,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(48.0),
        ),
      ),
    );
  }

  /// Shows a color picker dialog that allows the user to select a color from the palette.
  showColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Color picker'),
          content: SizedBox(
            width: ((48 + 4) * 5),
            child: Wrap(
              children: List.generate(baseColor.length, (index) {
                final item = baseColor[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(48.0),
                  onTap: () {
                    setState(() {
                      _color = item;
                      widget.onValueChanged.call(item);
                    });
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: item,
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                        borderRadius: BorderRadius.circular(48.0),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  /// Generates a color palette from the provided [Image] widget.
  Future<void> genPaletteFromImage(Image? image) async {
    final paletteColor = await PaletteGenerator.fromImageProvider(
      image!.image,
    );

    baseColor.addAll(paletteColor.colors);
  }
}
