import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../../Core/constants.dart';
import '../Events/events_screen.dart';
import '../EmptyEvents/empty_events_screen.dart';
import '../Profile/orgnizer_profile_screen.dart';
import 'Widgets/home_header.dart';
import 'Widgets/event_card.dart';
import 'Widgets/invite_banner.dart';
import 'Widgets/custom_drawer.dart';
import '../../Data/data_source/events_data_source.dart';
import '../../Data/repository/events_repository.dart';
import '../../Data/Models/event_model.dart';
import '../../Data/Models/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  int _currentIndex = 0;
  int _profileKey = 0;
  
  late EventsRepository repository;
  late Future<List<EventModel>> homeEventsFuture;
  late Future<List<EventModel>> nearbyEventsFuture;
  late Future<List<CategoryModel>> categoriesFuture;

  @override
  void initState() {
    super.initState();
    repository = EventsRepository(EventsDataSource());
    homeEventsFuture = repository.getHomeEvents();
    nearbyEventsFuture = repository.getNearbyEvents("51.5074,-0.1278");
    categoriesFuture = repository.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: AppColors.navyBlue,
      controller: _advancedDrawerController,
      drawer: const CustomDrawer(),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  HomeHeader(
                    controller: _advancedDrawerController, 
                    categoriesFuture: categoriesFuture
                  ),
                  const SizedBox(height: 40),
                  _buildSectionHeader("Upcoming Events", onSeeAllTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EventsScreen()),
                    );
                  }),
                  SizedBox(
                    height: 280,
                    child: FutureBuilder<List<EventModel>>(
                      future: homeEventsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return const Center(child: Text('Error loading events'));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No events found'));
                        }
                        final events = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 20),
                          itemCount: events.length,
                          itemBuilder: (context, index) => EventCard(event: events[index]),
                        );
                      },
                    ),
                  ),
                  const InviteBanner(),
                  _buildSectionHeader("Nearby You"),
                  SizedBox(
                    height: 280,
                    child: FutureBuilder<List<EventModel>>(
                      future: nearbyEventsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return const Center(child: Text('Error loading events'));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No events found nearby'));
                        }
                        final events = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 20),
                          itemCount: events.length,
                          itemBuilder: (context, index) => EventCard(event: events[index]),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const EmptyEventsScreen(),

            const Center(child: Text("Profile Page")),
            OrganizerProfileScreen(key: ValueKey(_profileKey)),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              if (index == 3) _profileKey++;
            });
          },
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

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAllTap}) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.navyBlue,
          ),
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: const Text("See All", style: TextStyle(color: Colors.grey)),
        ),
      ],
    ),
  );
}
