import 'package:flutter/material.dart';

import '../../../Core/constants.dart';

import '../../EventDetails/event_details_screen.dart';
import '../../../Data/Models/event_model.dart';

class SearchResultCard extends StatelessWidget {
  final EventModel event;

  const SearchResultCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
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
            width: 80,
            height: 80,
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
                  event.localDate ?? "Unknown Date",
                  style: const TextStyle(
                    color: AppColors.pumpkinOrange,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  event.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.navyBlue,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
