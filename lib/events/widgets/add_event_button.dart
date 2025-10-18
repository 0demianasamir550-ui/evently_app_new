import 'package:flutter/material.dart';
import '../../home/tabs/home_tab.dart';
import '../../services/firestore_service.dart';



class AddEventButton extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final String? selectedLocation;
  final String? categoryLabel;
  final String? categoryImage;
  final String buttonText;

  const AddEventButton({
    super.key,
    required this.titleController,
    required this.descriptionController,
    this.selectedDate,
    this.selectedTime,
    this.selectedLocation,
    this.categoryLabel,
    this.categoryImage,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (titleController.text.isEmpty || descriptionController.text.isEmpty || selectedDate == null || selectedTime == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please fill all required fields")),
          );
          return;
        }

        try {
          // إضافة الحدث في Firestore
          await FirestoreService.addEvent(
            title: titleController.text,
            description: descriptionController.text,
            date: selectedDate,
            time: selectedTime,
            location: selectedLocation,
            categoryLabel: categoryLabel,
            categoryImage: categoryImage,
          );

          // رسالة نجاح
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("✅ Event added successfully")),
          );

          // العودة للـ HomeTab
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeTab()),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("❌ Failed to add event: $e")),
          );
        }
      },
      child: Text(buttonText),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF5669FF),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }
}