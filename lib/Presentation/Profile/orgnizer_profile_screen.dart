import 'package:flutter/material.dart';
import '../../Core/constants.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_tabs.dart';

class OrganizerProfileScreen extends StatelessWidget {
  const OrganizerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.navyBlue),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert, color: AppColors.navyBlue),
              onPressed: () {},
            ),
          ],
        ),
        body: const Column(
          children: [
            ProfileHeader(),
            Expanded(child: ProfileTabs()),
          ],
        ),
      ),
    );
  }
}