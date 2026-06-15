import 'package:flutter/material.dart';
import '../../Core/constants.dart';
import 'Widgets/event_cards.dart';
import '../../Data/data_source/events_data_source.dart';
import '../../Data/repository/events_repository.dart';
import '../../Data/Models/event_model.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late EventsRepository repository;
  late Future<List<EventModel>> eventsFuture;

  @override
  void initState() {
    super.initState();
    repository = EventsRepository(EventsDataSource());
    eventsFuture = repository.getHomeEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Events",
          style: TextStyle(
            color: AppColors.navyBlue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.navyBlue, size: 28),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.navyBlue, size: 28),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<EventModel>>(
        future: eventsFuture,
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            itemCount: events.length,
            itemBuilder: (context, index) {
              return EventCards(event: events[index]);
            },
          );
        },
      ),
    );
  }
}

