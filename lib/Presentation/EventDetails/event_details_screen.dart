import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/constants.dart';
import 'Widgets/buy_ticket_button.dart';
import 'Widgets/event_details_sheet.dart';
import 'Widgets/event_header_image.dart';
import 'Widgets/header_bar.dart';
import 'Manager/event_details_cubit.dart';

class EventDetailsScreen extends StatelessWidget {
  final String? eventId;

  const EventDetailsScreen({super.key, this.eventId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventDetailsCubit()..loadEventDetails(eventId),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocBuilder<EventDetailsCubit, EventDetailsState>(
          builder: (context, state) {
            if (state is EventDetailsLoading || state is EventDetailsInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EventDetailsError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is EventDetailsLoaded) {
              final event = state.event;
              
              return Stack(
                children: [
                  EventHeaderImage(imageUrl: event?.imageUrl),
                  HeaderBar(eventId: eventId),
                  EventDetailsSheet(event: event), 
                  const BuyTicketButton(),
                ],
              );
            }
            return const SizedBox();
          }
        ),
      ),
    );
  }
}