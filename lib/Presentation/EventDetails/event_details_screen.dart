import 'package:flutter/material.dart';
import '../../../Core/constants.dart';
import 'Widgets/buy_ticket_button.dart';
import 'Widgets/event_details_sheet.dart';
import 'Widgets/event_header_image.dart';
import 'Widgets/header_bar.dart';


class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          EventHeaderImage(),
          HeaderBar(),
          EventDetailsSheet(),
          BuyTicketButton(),
        ],
      ),
    );
  }
}