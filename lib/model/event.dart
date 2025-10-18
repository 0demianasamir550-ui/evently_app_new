class Event {
  static const String collectionName = 'Events';

  String id;
  String title;
  String description;
  String category;
  String eventImage;
  DateTime date;
  String time;
  String location;

  Event({
    this.id = '',
    required this.title,
    required this.description,
    required this.category,
    required this.eventImage,
    required this.date,
    required this.time,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'eventImage': eventImage,
      'date': date.toIso8601String(),
      'time': time,
      'location': location,
    };
  }

  factory Event.fromJson(Map<String, dynamic> json, String id) {
    return Event(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? 'all',
      eventImage: json['eventImage'] ?? '',
      date: DateTime.parse(json['date']),
      time: json['time'] ?? '',
      location: json['location'] ?? '',
    );
  }
}