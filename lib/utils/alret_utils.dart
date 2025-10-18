import 'package:flutter/material.dart';

class AlertUtils {
  /// 🔔 لعرض Alert Dialog يحتوي على عنوان + رسالة + OK / Cancel
  static void showConfirmDialog(
      BuildContext context, {
        required String title,
        required String message,
        required VoidCallback onConfirm,
      }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // يغلق الـ Dialog
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // يقفل الـ Dialog
              onConfirm(); // ينفذ الأكشن اللي المستخدم وافق عليه
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}