import 'package:flutter/material.dart';
import '../../../Data/Local/database_helper.dart';
import '../../../Data/Local/shared_prefs_helper.dart';
import '../../../Data/data_source/events_data_source.dart';
import '../../../Data/repository/events_repository.dart';
import '../../../Data/Models/event_model.dart';
import '../../Events/Widgets/event_cards.dart';

class FavEventsTab extends StatefulWidget {
  const FavEventsTab({super.key});

  @override
  State<FavEventsTab> createState() => _FavEventsTabState();
}

class _FavEventsTabState extends State<FavEventsTab> {
  List<EventModel> _favEvents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final userId = await SharedPrefsHelper.getUserId();
    if (userId == null) {
      if (mounted) setState(() { _isLoading = false; });
      return;
    }

    final favRows = await DatabaseHelper.instance.getUserFavorites(userId);
    final repository = EventsRepository(EventsDataSource());
    final List<EventModel> events = [];

    for (final row in favRows) {
      final eventId = row['event_id'].toString();
      try {
        final event = await repository.getEventDetails(eventId);
        if (event != null) events.add(event);
      } catch (_) {
        // Skip events that can't be loaded
      }
    }

    if (mounted) {
      setState(() {
        _favEvents = events;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_favEvents.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_border, size: 60, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              "No favorite events yet",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      itemCount: _favEvents.length,
      itemBuilder: (context, index) {
        return EventCards(event: _favEvents[index]);
      },
    );
  }
}
