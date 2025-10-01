import 'package:flutter/material.dart';
import 'edit_event.dart';

class EventDetailsPage extends StatelessWidget {
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final String location;

  const EventDetailsPage({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xFF5669FF);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final descriptionColor = isDark ? Colors.white : Colors.black;
    final backgroundColor = isDark ? const Color(0xFF101127) : theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),


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
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),


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
                  Text(location, style: TextStyle(color: mainColor)),
                ],
              ),
            ),

            const SizedBox(height: 16),


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


            Text(
              description,
              style: TextStyle(fontSize: 16, color: descriptionColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}