import 'package:flutter/material.dart';
import 'edit_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventDetailsPage extends StatelessWidget {
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final String location;
  final String? eventId; // 🔹 لإضافة إمكانية تعديل/حذف الحدث في Firestore

  const EventDetailsPage({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    this.eventId,
  });

  Future<void> _deleteEvent(BuildContext context) async {
    if (eventId != null) {
      await FirebaseFirestore.instance.collection('events').doc(eventId).delete();
      Navigator.pop(context); // بعد الحذف نرجع للخلف
    }
  }

  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xFF5669FF);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final descriptionColor = isDark ? Colors.white : Colors.black;
    final backgroundColor =
    isDark ? const Color(0xFF101127) : theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              // الصف العلوي: رجوع + العنوان + Edit/Delete
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: mainColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  const Text(
                    'Event Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditEventPage(
                                title: title,
                                description: description,
                                date: date,
                                time: time,
                                location: location,
                                eventId: eventId, // 🔹 إرسال الـ eventId لتحديث Firestore
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white.withOpacity(0.8),
                          child: const Icon(
                            Icons.edit,
                            color: mainColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await _deleteEvent(context); // 🔹 حذف الحدث
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // الصورة
              Image.asset(
                "assets/images/bookclub.png",
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 24),

              // عنوان الحدث
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // التاريخ والوقت
              Container(
                width: double.infinity,
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: mainColor, width: 2),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calculate, color: mainColor),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ${date.toLocal().toString().split(' ')[0]}',
                          style: const TextStyle(color: mainColor),
                        ),
                        Text(
                          'Time: ${time.format(context)}',
                          style: const TextStyle(color: mainColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // المكان
              Container(
                width: double.infinity,
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: mainColor, width: 2),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/icon_location.png',
                      width: 24,
                      height: 24,
                      color: mainColor,
                    ),
                    const SizedBox(width: 12),
                    Text(location, style: const TextStyle(color: mainColor)),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // خريطة افتراضية
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                  image: const DecorationImage(
                    image: AssetImage('assets/images/map.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // الوصف
              Text(
                description,
                style: TextStyle(fontSize: 16, color: descriptionColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}