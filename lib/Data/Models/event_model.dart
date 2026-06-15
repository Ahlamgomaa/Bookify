class EventModel {
  final String id;
  final String name;
  final String? imageUrl;
  final String? localDate;
  final String? localTime;
  final String? venueName;
  final String? cityName;
  final String? description;

  EventModel({
    required this.id,
    required this.name,
    this.imageUrl,
    this.localDate,
    this.localTime,
    this.venueName,
    this.cityName,
    this.description,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    String? imgUrl;
    if (json['images'] != null && (json['images'] as List).isNotEmpty) {
      imgUrl = json['images'][0]['url'];
    }

    String? date;
    String? time;
    if (json['dates'] != null && json['dates']['start'] != null) {
      date = json['dates']['start']['localDate'];
      time = json['dates']['start']['localTime'];
    }

    String? vName;
    String? cName;
    if (json['_embedded'] != null && json['_embedded']['venues'] != null && (json['_embedded']['venues'] as List).isNotEmpty) {
      final venue = json['_embedded']['venues'][0];
      vName = venue['name'];
      if (venue['city'] != null) {
        cName = venue['city']['name'];
      }
    }

    return EventModel(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown Event',
      imageUrl: imgUrl,
      localDate: date,
      localTime: time,
      venueName: vName,
      cityName: cName,
      description: json['info'] ?? json['description'],
    );
  }
}
