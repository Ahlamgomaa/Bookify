import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../../Core/constants.dart';
import '../Events/events_screen.dart';
import '../EmptyEvents/empty_events_screen.dart';
import '../Profile/orgnizer_profile_screen.dart';
import 'Widgets/home_header.dart';
import 'Widgets/event_card.dart';
import 'Widgets/invite_banner.dart';
import 'Widgets/custom_drawer.dart';
import 'Manager/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  int _currentIndex = 0;
  int _profileKey = 0;

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
            BlocProvider(
              create: (context) => HomeCubit()..loadHomeData(),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading || state is HomeInitial) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is HomeLoaded) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          HomeHeader(
                            controller: _advancedDrawerController,
                            categories: state.categories,
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
                            child: state.homeEvents.isEmpty
                                ? const Center(child: Text('No events found'))
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.only(left: 20),
                                    itemCount: state.homeEvents.length,
                                    itemBuilder: (context, index) => EventCard(event: state.homeEvents[index]),
                                  ),
                          ),
                          const InviteBanner(),
                          _buildSectionHeader("Nearby You"),
                          SizedBox(
                            height: 280,
                            child: state.nearbyEvents.isEmpty
                                ? const Center(child: Text('No events found nearby'))
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.only(left: 20),
                                    itemCount: state.nearbyEvents.length,
                                    itemBuilder: (context, index) => EventCard(event: state.nearbyEvents[index]),
                                  ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            const EmptyEventsScreen(),
            OrganizerProfileScreen(key: ValueKey(_profileKey)),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  if (index == 2) _profileKey++;
                });
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.navyBlue,
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
              selectedIconTheme: const IconThemeData(size: 28),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore_outlined),
                  activeIcon: Icon(Icons.explore),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event_outlined),
                  activeIcon: Icon(Icons.event),
                  label: 'Events',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
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
