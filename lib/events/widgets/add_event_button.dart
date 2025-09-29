import 'package:flutter/material.dart';
import 'package:evently_app_new/l10n/app_localizations.dart';
import 'package:evently_app_new/events/add_event.dart';

class AddEventButton extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final String? selectedLocation;
  final String? buttonText;

  const AddEventButton({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedLocation,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final text = buttonText ?? localizations.create_event;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5669FF),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () {
          if (titleController.text.isEmpty ||
              descriptionController.text.isEmpty ||
              selectedDate == null ||
              selectedTime == null ||
              selectedLocation == null ||
              selectedLocation!.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(localizations.fill_all_fields)),
            );
            return;
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEventPage(
                title: titleController.text,
                description: descriptionController.text,
                date: selectedDate,
                time: selectedTime,
                location: selectedLocation,
              ),
            ),
          );
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}