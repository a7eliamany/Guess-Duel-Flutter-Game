import 'package:flutter/material.dart';

class CText extends StatelessWidget {
  final String data;
  final double size;
  final Color? color;
  const CText({super.key, required this.data, required this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
