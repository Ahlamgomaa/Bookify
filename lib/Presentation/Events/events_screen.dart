import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Core/constants.dart';
import 'Widgets/event_cards.dart';
import 'Manager/events_cubit.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsCubit()..loadEvents(),
      child: Scaffold(
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
        body: BlocBuilder<EventsCubit, EventsState>(
          builder: (context, state) {
            if (state is EventsLoading || state is EventsInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EventsError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is EventsLoaded) {
              if (state.events.isEmpty) {
                return const Center(child: Text('No events found'));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                itemCount: state.events.length,
                itemBuilder: (context, index) {
                  return EventCards(event: state.events[index]);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
