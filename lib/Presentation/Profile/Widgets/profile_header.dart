import 'package:flutter/material.dart';
import '../../../Core/constants.dart';
import '../../../Data/Local/database_helper.dart';
import '../../../Data/Local/shared_prefs_helper.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final userId = await SharedPrefsHelper.getUserId();
    if (userId == null) return;
    final user = await DatabaseHelper.instance.getUserById(userId);
    if (user != null && mounted) {
      setState(() {
        _userName = user['name'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 45,
          backgroundColor: AppColors.navyBlue,
          child: Icon(Icons.person, size: 45, color: Colors.white),
        ),
        const SizedBox(height: 15),
        Text(
          _userName.isEmpty ? '...' : _userName,
          style: const TextStyle(
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
