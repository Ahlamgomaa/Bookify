import 'package:flutter/material.dart';

import '../../../Core/constants.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

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
              ),
              const SizedBox(height: 15),
              const Text(
                "Ahlam Gomaa",
                style: TextStyle(
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
                onTap: () {},
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
