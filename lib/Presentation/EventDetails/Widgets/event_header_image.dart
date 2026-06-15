import 'package:flutter/material.dart';

class EventHeaderImage extends StatelessWidget {
  final String? imageUrl;
  const EventHeaderImage({super.key, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0, left: 0, right: 0, height: 350,
      child: imageUrl != null
          ? Image.network(imageUrl!, fit: BoxFit.cover)
          : Container(color: Colors.grey),
    );
  }
}