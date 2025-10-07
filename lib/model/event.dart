class Event {
  static const String collectionName = 'Events';
  String id;
  String title;
  String description;
  String eventImage;
  String eventName;
  DateTime eventDateTime;
  String eventTime;
  bool isFavorite;

  Event({
    this.id = '',
    required this.title,
    required this.description,
    required this.eventImage,
    required this.eventName,
    required this.eventDateTime,
    required this.eventTime,
    this.isFavorite = false,
  });

  Event.fromFireStore(Map<String,dynamic> data)
      : this(
    id: data['id'],
    title: data['title'],
    description: data['description'],
    eventImage: data['event_image'],
    eventName: data['event_name'],
    eventDateTime: DateTime.fromMicrosecondsSinceEpoch(data['event_date_time']),
    eventTime: data['event_time'],
    isFavorite: data['is_favorite'],
  );

  // تحويل الحدث لـ Map علشان يتخزن في Firestore
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'event_image': eventImage,
      'event_name': eventName,
      'event_date_time': eventDateTime.microsecondsSinceEpoch,
      'event_time': eventTime,
      'is_favorite': isFavorite,
    };
  }
}