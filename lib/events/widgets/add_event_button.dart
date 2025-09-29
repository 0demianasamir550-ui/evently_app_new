// lib/events/widgets/add_event_button.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently_app_new/providers/app_theme.dart';
import 'package:evently_app_new/providers/app_language_provider.dart';
import 'package:evently_app_new/l10n/app_localizations.dart';

class AddEventButton extends StatelessWidget {
  final TextEditingController titleController;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final String? selectedLocation;

  const AddEventButton({
    super.key,
    required this.titleController,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedLocation,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final languageProvider = Provider.of<AppLanguageProvider>(context);
    final localizations = AppLocalizations.of(context)!;

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
          if (titleController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(localizations.fill_all_fields + " (Title)")),
            );
            return;
          }
          if (selectedDate == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(localizations.fill_all_fields + " (Date)")),
            );
            return;
          }
          if (selectedTime == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(localizations.fill_all_fields + " (Time)")),
            );
            return;
          }
          if (selectedLocation == null || selectedLocation!.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(localizations.fill_all_fields + " (Location)")),
            );
            return;
          }

          // لو كل الحقول صح، اعمل Refresh لنفس الصفحة
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Event Added Successfully!")),
          );
          // إعادة بناء الصفحة
          (context as Element).reassemble();
        },
        child: Text(
          localizations.create_event,
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