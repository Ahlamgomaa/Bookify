import 'package:flutter/material.dart';

import '../../../Core/constants.dart';

import '../../EventDetails/event_details_screen.dart';
import '../../../Data/Models/event_model.dart';

class EventCards extends StatelessWidget {
  final EventModel event;

  const EventCards({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventDetailsScreen(eventId: event.id)),
          );
        },
        child: Row(
          children: [
          Container(
            width: 90,
            height: 90,
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
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.localDate ?? "Date Unknown",
                  style: const TextStyle(
                    color:AppColors.pumpkinOrange,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  event.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navyBlue,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14,
                        color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        event.venueName ?? "Unknown Location",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}