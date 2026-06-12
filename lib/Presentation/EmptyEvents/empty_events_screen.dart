import 'package:flutter/material.dart';
import '../../Core/constants.dart';
import 'Widgets/empty_state_body.dart';
import 'Widgets/event_tabs.dart';
import 'Widgets/explore_events_button.dart';


class EmptyEventsScreen extends StatefulWidget {
  const EmptyEventsScreen({super.key});

  @override
  State<EmptyEventsScreen> createState() => _EmptyEventsScreenState();
}

class _EmptyEventsScreenState extends State<EmptyEventsScreen> {
  bool isUpcoming = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Events", style: TextStyle(color: AppColors.navyBlue, fontSize: 20, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.navyBlue),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [Padding(padding: EdgeInsets.only(right: 20), child: Icon(Icons.more_vert, color: AppColors.navyBlue))],
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          EventTabs(
            isUpcoming: isUpcoming,
            onTabChanged: (val) => setState(() => isUpcoming = val),
          ),
          const Spacer(),
          EmptyStateBody(isUpcoming: isUpcoming),
          const Spacer(),
          const ExploreEventsButton(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}