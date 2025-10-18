import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently_app_new/events/widgets/event_circle_widget.dart' hide EventCategoriesList;
import 'package:evently_app_new/events/widgets/event_date.dart';
import 'package:evently_app_new/events/widgets/event_time.dart';
import 'package:evently_app_new/events/widgets/rectangle_title_description.dart';
import 'package:evently_app_new/events/widgets/location.dart';
import 'package:evently_app_new/providers/app_theme.dart';
import 'package:evently_app_new/l10n/app_localizations.dart';
import 'event_details.dart';
import 'package:evently_app_new/events/widgets/event_categories_list.dart'; // تأكد من استدعاء هذا الملف

class AddEventPage extends StatefulWidget {
  final String? title;
  final String? description;
  final DateTime? date;
  final TimeOfDay? time;
  final String? location;

  const AddEventPage({
    super.key,
    this.title,
    this.description,
    this.date,
    this.time,
    this.location,
  });

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedLocation;
  String? selectedCategoryLabel;
  String? selectedCategoryImage;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title ?? '');
    descriptionController = TextEditingController(text: widget.description ?? '');
    selectedDate = widget.date;
    selectedTime = widget.time;
    selectedLocation = widget.location;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final localizations = AppLocalizations.of(context)!;
    final isDark = themeProvider.isDarkMode();
    final backgroundColor = isDark ? const Color(0xFF101127) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      localizations.add_event,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF5669FF),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // تم إزالة const هنا
                EventCategoriesList(
                  onCategorySelected: (label, image) {
                    setState(() {
                      selectedCategoryLabel = label;
                      selectedCategoryImage = image;
                    });
                  },
                ),
                const SizedBox(height: 24),
                RectangleTitleDescriptionWidget(
                  titleController: titleController,
                  descriptionController: descriptionController,
                ),
                const SizedBox(height: 24),
                EventDateWidget(
                  selectedDate: selectedDate,
                  onDateChanged: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
                const SizedBox(height: 16),
                EventTimeWidget(
                  selectedTime: selectedTime,
                  onTimeChanged: (time) {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                ),
                const SizedBox(height: 24),
                LocationWidget(
                  selectedLocation: selectedLocation,
                  onLocationChanged: (location) {
                    setState(() {
                      selectedLocation = location;
                    });
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5669FF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      if (titleController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty &&
                          selectedDate != null &&
                          selectedTime != null &&
                          selectedLocation != null &&
                          selectedLocation!.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EventDetailsPage(
                              title: titleController.text,
                              description: descriptionController.text,
                              date: selectedDate!,
                              time: selectedTime!,
                              location: selectedLocation!,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please fill all fields")),
                        );
                      }
                    },
                    child: Text(
                      localizations.save_changes,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}