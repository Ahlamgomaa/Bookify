import 'package:flutter/material.dart';
import '../../Core/constants.dart';
import 'Widgets/empty_state_body.dart';
import 'Widgets/event_tabs.dart';
import 'Widgets/explore_events_button.dart';
import '../../Data/data_source/events_data_source.dart';
import '../../Data/repository/events_repository.dart';
import '../Events/Widgets/event_cards.dart';
import '../../../Data/Models/event_model.dart';

class EmptyEventsScreen extends StatefulWidget {
  const EmptyEventsScreen({super.key});

  @override
  State<EmptyEventsScreen> createState() => _EmptyEventsScreenState();
}

class _EmptyEventsScreenState extends State<EmptyEventsScreen> {
  bool isUpcoming = true;

  late EventsRepository repository;
  late Future<List<EventModel>> upcomingEventsFuture;
  late Future<List<EventModel>> pastEventsFuture;

  @override
  void initState() {
    super.initState();
    repository = EventsRepository(EventsDataSource());
    upcomingEventsFuture = repository.getHomeEvents();
    pastEventsFuture = repository.getPastEvents();
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
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.navyBlue),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.more_vert, color: AppColors.navyBlue),
          ),
        ],
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          EventTabs(
            isUpcoming: isUpcoming,
            onTabChanged: (val) => setState(() => isUpcoming = val),
          ),
          Expanded(
            child: FutureBuilder<List<EventModel>>(
              future: isUpcoming ? upcomingEventsFuture : pastEventsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading events'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmptyStateBody(isUpcoming: isUpcoming),
                      const SizedBox(height: 30),
                      const ExploreEventsButton(),
                    ],
                  );
                }

                final events = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return EventCards(event: events[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
