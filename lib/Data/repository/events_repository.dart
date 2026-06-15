import '../data_source/events_data_source.dart';
import '../Models/event_model.dart';
import '../Models/category_model.dart';

class EventsRepository {
  final EventsDataSource dataSource;

  EventsRepository(this.dataSource);

  Future<List<EventModel>> getHomeEvents() async {
    try {
      final data = await dataSource.getHomeEvents();
      if (data['_embedded'] != null && data['_embedded']['events'] != null) {
        final List events = data['_embedded']['events'];
        return events.map((e) => EventModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print("Error getting events: $e");
      return [];
    }
  }

  Future<List<EventModel>> searchEvents(String keyword) async {
    try {
      final data = await dataSource.searchEvents(keyword);
      if (data['_embedded'] != null && data['_embedded']['events'] != null) {
        final List events = data['_embedded']['events'];
        return events.map((e) => EventModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print("Error searching events: $e");
      return [];
    }
  }

  Future<EventModel?> getEventDetails(String eventId) async {
    try {
      final data = await dataSource.getEventDetails(eventId);
      if (data != null) {
        return EventModel.fromJson(data);
      }
      return null;
    } catch (e) {
      print("Error getting event details: $e");
      return null;
    }
  }

  Future<List<EventModel>> getNearbyEvents(String latlong) async {
    try {
      final data = await dataSource.getNearbyEvents(latlong);
      if (data['_embedded'] != null && data['_embedded']['events'] != null) {
        final List events = data['_embedded']['events'];
        return events.map((e) => EventModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print("Error getting nearby events: $e");
      return [];
    }
  }

  Future<List<EventModel>> getPastEvents() async {
    try {
      final data = await dataSource.getPastEvents();
      if (data['_embedded'] != null && data['_embedded']['events'] != null) {
        final List events = data['_embedded']['events'];
        return events.map((e) => EventModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print("Error getting past events: $e");
      return [];
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final data = await dataSource.getCategories();
      if (data['_embedded'] != null && data['_embedded']['classifications'] != null) {
        final classifications = data['_embedded']['classifications'] as List<dynamic>;
        return classifications.map((item) {
          final segment = item['segment'];
          return CategoryModel(
            id: segment?['id'] ?? item['id'] ?? '',
            name: segment?['name'] ?? 'Unknown',
          );
        }).where((cat) => cat.name != 'Unknown' && cat.name != 'Undefined').toList();
      }
      return [];
    } catch (e) {
      print("Error getting categories: $e");
      return [];
    }
  }
}
