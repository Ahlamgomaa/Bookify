import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../../Core/constants.dart';
import 'widgets/home_header.dart';
import 'widgets/event_card.dart';
import 'widgets/invite_banner.dart';
import 'widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: AppColors.navyBlue,
      controller: _advancedDrawerController,
      drawer: const CustomDrawer(),
      child: Scaffold(
        body: _currentIndex == 0
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    HomeHeader(controller: _advancedDrawerController),
                    const SizedBox(height: 40),
                    _buildSectionHeader("Upcoming Events"),
                    SizedBox(
                      height: 280,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 20),
                        itemCount: 2,
                        itemBuilder: (context, index) => const EventCard(),
                      ),
                    ),
                    const InviteBanner(),
                    _buildSectionHeader("Nearby You"),
                    const SizedBox(height: 100),
                  ],
                ),
              )
            : Center(child: Text("Page $_currentIndex")),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.navyBlue,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:AppColors.navyBlue),
        ),
        const Text("See All", style: TextStyle(color: Colors.grey)),
      ],
    ),
  );
}
