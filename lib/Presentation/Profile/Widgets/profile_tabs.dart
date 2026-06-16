import 'package:flutter/material.dart';
import '../../../Core/constants.dart';
import 'fav_events_tab.dart';
import 'review_card.dart';

class ProfileTabs extends StatelessWidget {
  const ProfileTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TabBar(
          labelColor: AppColors.navyBlue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.navyBlue,
          tabs: [
            Tab(text: "About"),
            Tab(text: "Fav Events"),
            Tab(text: "Reviews"),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More",
                  style: TextStyle(color: Colors.grey, height: 1.5),
                ),
              ),

              const FavEventsTab(),

              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                children: [ReviewCard(), ReviewCard(), ReviewCard()],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
