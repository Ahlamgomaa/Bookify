import 'package:flutter/material.dart';
import '../../../Core/constants.dart';
import '../../EventDetails/event_details_screen.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EventDetailsScreen()),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade200, blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "10\nJUNE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(Icons.bookmark, color: Colors.red, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "International Band Music",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.navyBlue,
              ),
            ),
            const SizedBox(height: 5),
            const Row(
              children: [
                Icon(Icons.people, size: 16, color: AppColors.pumpkinOrange),
                Text(
                  " +20 Going",
                  style: TextStyle(color: AppColors.pumpkinOrange),
                ),
              ],
            ),
            const Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey),
                Text(" 36 Guild St, London"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}