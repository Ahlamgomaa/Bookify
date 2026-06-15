import '../../network/dio_helper.dart';

class EventsDataSource {
  Future<dynamic> getHomeEvents() async {
    final response = await DioHelper.getData(
      url: 'events.json',
      query: {
        'size': 20,
        'sort': 'date,asc',
      },
    );
    return response.data;
  }

  Future<dynamic> searchEvents(String keyword) async {
    final response = await DioHelper.getData(
      url: 'events.json',
      query: {
        'keyword': keyword,
        'size': 20,
      },
    );
    return response.data;
  }

  Future<dynamic> getEventDetails(String eventId) async {
    final response = await DioHelper.getData(
      url: 'events/$eventId.json',
    );
    return response.data;
  }

  Future<dynamic> getNearbyEvents(String latlong) async {
    final response = await DioHelper.getData(
      url: 'events.json',
      query: {
        'latlong': latlong,
        'size': 20,
        'sort': 'distance,asc',
      },
    );
    return response.data;
  }

  Future<dynamic> getPastEvents() async {
    final response = await DioHelper.getData(
      url: 'events.json',
      query: {
        'size': 20,
        'sort': 'date,desc',
      },
    );
    return response.data;
  }

  Future<dynamic> getCategories() async {
    final response = await DioHelper.getData(
      url: 'classifications.json',
      query: {
        'size': 10,
      },
    );
    return response.data;
  }
}
