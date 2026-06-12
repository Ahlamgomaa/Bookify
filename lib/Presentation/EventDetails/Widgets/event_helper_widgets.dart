import 'package:flutter/material.dart';
import '../../../Core/constants.dart';

Widget buildAvatars() {
  return SizedBox(
    width: 70, height: 30,
    child: Stack(
      children: [
        Positioned(left: 0, child: CircleAvatar(radius: 15, backgroundColor: Colors.orange[200], child: const Icon(Icons.person, size: 18, color: Colors.white))),
        Positioned(left: 20, child: CircleAvatar(radius: 15, backgroundColor: Colors.blue[200], child: const Icon(Icons.person, size: 18, color: Colors.white))),
        Positioned(left: 40, child: CircleAvatar(radius: 15, backgroundColor: Colors.teal[200], child: const Icon(Icons.person, size: 18, color: Colors.white))),
      ],
    ),
  );
}

Widget buildIconTile(IconData icon, String title, String sub) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5, offset: const Offset(0, 3))]),
          child: Icon(icon, color: AppColors.navyBlue),
        ),
        const SizedBox(width: 15),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navyBlue)), const SizedBox(height: 3), Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 13))]),
      ],
    ),
  );
}