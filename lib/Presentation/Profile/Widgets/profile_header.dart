import 'package:flutter/material.dart';
import '../../../Core/constants.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(radius: 45, backgroundColor: AppColors.navyBlue),
        const SizedBox(height: 15),
        const Text(
          "Ahlam Gomaa",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.navyBlue,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStat("350", "Following"),
            const SizedBox(width: 40),
            _buildStat("346", "Followers"),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              "Follow",
              AppColors.navyBlue,
              Colors.white,
              Icons.person_add,
            ),
            const SizedBox(width: 15),
            _buildButton(
              "Messages",
              Colors.white,
              AppColors.navyBlue,
              Icons.chat_bubble_outline,
              true,
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget _buildStat(String val, String label) => Column(
    children: [
      Text(
        val,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.navyBlue),
      ),
      Text(label, style: const TextStyle(color: Colors.grey)),
    ],
  );

  Widget _buildButton(
    String text,
    Color bg,
    Color txt,
    IconData icon, [
    bool border = false,
  ]) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
      border: border ? Border.all(color: AppColors.navyBlue) : null,
    ),
    child: Row(
      children: [
        Icon(icon, color: txt, size: 18),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: txt)),
      ],
    ),
  );
}
