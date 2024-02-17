import 'package:flutter/material.dart';

class Pixel extends StatefulWidget {
  Pixel({
    super.key,
    required this.color,
  });
  var color;
  @override
  State<Pixel> createState() => _PixelState();
}

class _PixelState extends State<Pixel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.color, borderRadius: BorderRadius.circular(4)),
      margin: EdgeInsets.all(1),
    );
  }
}
