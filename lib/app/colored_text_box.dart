import 'package:flutter/material.dart';

class ColoredTextBox extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final Color color;

  const ColoredTextBox({
    Key? key,
    required this.text,
    this.width,
    this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('$text tapped');
      },
      child: Container(
        width: width,
        height: 100,
        color: color,
        child: SizedBox(child: Text(text, maxLines: 1)),
      ),
    );
  }
}
