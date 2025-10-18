import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class FirestoreService {
  static Future<void> addEvent({
    required String title,
    required String description,
    DateTime? date,
    TimeOfDay? time,
    String? location,
    String? categoryLabel,
    String? categoryImage,
  }) async {
    try {
      // ✅ تأكد من تهيئة Firebase قبل أي عملية
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }

      await FirebaseFirestore.instance.collection('events').add({
        'title': title,
        'description': description,
        'date': date != null ? Timestamp.fromDate(date) : null,
        'time': time != null ? '${time.hour}:${time.minute}' : null,
        'location': location,
        'categoryLabel': categoryLabel,
        'categoryImage': categoryImage,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print('✅ Event added successfully');
    } catch (e) {
      print('❌ Error adding event: $e');
    }
  }
}