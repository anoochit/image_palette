import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ImagePalette extends StatefulWidget {
  const ImagePalette({super.key, required this.onValueChanged, this.image});

  final ValueChanged<Color> onValueChanged;
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

  // base color
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

  Future<void> genPaletteFromImage(Image? image) async {
    final paletteColor = await PaletteGenerator.fromImageProvider(
      image!.image,
    );

    baseColor.addAll(paletteColor.colors);
  }
}
