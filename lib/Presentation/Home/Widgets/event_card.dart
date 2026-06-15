import 'package:flutter/material.dart';
import '../../../Core/constants.dart';
import '../../EventDetails/event_details_screen.dart';
import '../../../Data/Models/event_model.dart';

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetailsScreen(eventId: event.id)),
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
                    image: event.imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(event.imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
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
                    child: Text(
                      "${event.localDate?.split('-').last ?? '10'}\n${_getMonth(event.localDate)}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
            Text(
              event.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.navyBlue,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
                Expanded(
                  child: Text(
                    " 36 Guild Street London, UK",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getMonth(String? date) {
    if (date == null) return 'JUNE';
    final parts = date.split('-');
    if (parts.length >= 2) {
      switch (parts[1]) {
        case '01': return 'JAN';
        case '02': return 'FEB';
        case '03': return 'MAR';
        case '04': return 'APR';
        case '05': return 'MAY';
        case '06': return 'JUN';
        case '07': return 'JUL';
        case '08': return 'AUG';
        case '09': return 'SEP';
        case '10': return 'OCT';
        case '11': return 'NOV';
        case '12': return 'DEC';
      }
    }
    return 'JUNE';
  }
}