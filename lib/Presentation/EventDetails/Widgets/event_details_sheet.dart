import 'package:flutter/material.dart';
import '../../../Core/constants.dart';
import 'invite_card.dart';
import 'event_helper_widgets.dart';
import '../../../Data/Models/event_model.dart';

class EventDetailsSheet extends StatelessWidget {
  final EventModel? event;

  const EventDetailsSheet({super.key, this.event});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65, minChildSize: 0.65, maxChildSize: 0.9,
      builder: (context, controller) {
        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 35),
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 100),
                children: [
                  Text(
                    event?.name ?? "Event Name", 
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navyBlue)
                  ),
                  const SizedBox(height: 25),
                  buildIconTile(
                    Icons.calendar_month, 
                    event?.localDate ?? "Unknown Date", 
                    event?.localTime ?? "Unknown Time"
                  ),
                  buildIconTile(
                    Icons.location_on_outlined, 
                    event?.venueName ?? "Unknown Venue", 
                    event?.cityName ?? "Unknown City"
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(radius: 25, backgroundColor: Colors.grey),
                    title: const Text("Ahlam Gomaa", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navyBlue)),
                    subtitle: const Text("Organizer"),
                    trailing: OutlinedButton(
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.grey), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      onPressed: () {},
                      child: const Text("Follow", style: TextStyle(color: AppColors.navyBlue)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("About Event", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navyBlue)),
                  const SizedBox(height: 10),
                  Text(
                    event?.description ?? "No description available for this event.", 
                    style: const TextStyle(color: Colors.grey, height: 1.5)
                  ),
                ],
              ),
            ),
            const Positioned(top: 0, left: 20, right: 20, child: InviteCard()),
          ],
        );
      },
    );
  }
}