import 'package:flutter/material.dart';

import '../../../Core/constants.dart';
import '../../../Data/Local/database_helper.dart';
import '../../../Data/Local/shared_prefs_helper.dart';
import '../../Auth/SignIn/sign_in_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
    return Material(
      color: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.navyBlue,
                child: Icon(Icons.person, color: Colors.white, size: 35),
              ),
              const SizedBox(height: 15),
              Text(
                _userName,
                style: const TextStyle(
                  color: AppColors.navyBlue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              ListTile(
                leading: const Icon(
                  Icons.person_outline,
                  color: AppColors.navyBlue,
                ),
                title: const Text(
                  "My Profile",
                  style: TextStyle(
                    color: AppColors.navyBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.chat_bubble_outline,
                  color: AppColors.navyBlue,
                ),
                title: const Text(
                  "Message",
                  style: TextStyle(
                    color: AppColors.navyBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.calendar_today,
                  color: AppColors.navyBlue,
                ),
                title: const Text(
                  "Calendar",
                  style: TextStyle(
                    color: AppColors.navyBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.bookmark_border,
                  color: AppColors.navyBlue,
                ),
                title: const Text(
                  "Bookmark",
                  style: TextStyle(
                    color: AppColors.navyBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {},
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.logout, color:Colors.red),
                title: const Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.red ,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () async {
                  await SharedPrefsHelper.logout();
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const SignInScreen()),
                      (route) => false,
                    );
                  }
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
