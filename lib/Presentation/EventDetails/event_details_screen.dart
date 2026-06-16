import 'package:flutter/material.dart';
import '../../../Core/constants.dart';
import 'Widgets/buy_ticket_button.dart';
import 'Widgets/event_details_sheet.dart';
import 'Widgets/event_header_image.dart';
import 'Widgets/header_bar.dart';


import '../../Data/data_source/events_data_source.dart';
import '../../Data/repository/events_repository.dart';
import '../../Data/Models/event_model.dart';

class EventDetailsScreen extends StatefulWidget {
  final String? eventId;

  const EventDetailsScreen({super.key, this.eventId});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late EventsRepository repository;
  late Future<EventModel?> eventFuture;

  @override
  void initState() {
    super.initState();
    repository = EventsRepository(EventsDataSource());
    if (widget.eventId != null) {
      eventFuture = repository.getEventDetails(widget.eventId!);
    } else {
      eventFuture = Future.value(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FutureBuilder<EventModel?>(
        future: eventFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final event = snapshot.data;
          
          return Stack(
            children: [
              EventHeaderImage(imageUrl: event?.imageUrl),
              HeaderBar(eventId: widget.eventId),
              EventDetailsSheet(event: event), 
              const BuyTicketButton(),
            ],
          );
        }
      ),
    );
  }
}