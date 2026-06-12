import 'package:flutter/material.dart';

class EventHeaderImage extends StatelessWidget {
  const EventHeaderImage({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0, left: 0, right: 0, height: 350,
      child: Image.asset('assets/images/onboarding1.jpg', fit: BoxFit.cover),
    );
  }
}