import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUtils {
  // اسم المجموعة يجب أن يكون متطابقاً مع ما يتم استدعاؤه في HomeTab
  // (والذي كان 'events' بالحروف الصغيرة)
  static const String eventsCollection = "events";

  /// ✅ إضافة حدث جديد إلى Firestore
  static Future<void> addEvent({
    required String title,
    required String description,
    required DateTime date,
    required String time,
    required String location,
    required String category,
    required String imagePath, // رابط الصورة الذي تم رفعه على التخزين
  }) async {
    try {
      final eventData = {
        "title": title,
        "description": description,
        // يفضل حفظ التاريخ كـ Timestamp لسهولة الترتيب والتعامل
        // هنا تم تركه كـ Iso8601String كما كان، ولكن يفضل Timestamp
        "date": date.toIso8601String(),
        "time": time,
        "location": location,
        // مفتاح مطابق لـ HomeTab
        "category": category,
        // تصحيح: استخدام مفتاح "image" بدلاً من "imagePath" ليتطابق مع HomeTab
        "image": imagePath,
        // هذا الحقل مطلوب لعملية الترتيب في HomeTab
        "createdAt": FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection(eventsCollection)
          .add(eventData);

      print("✅ Event added successfully!");
    } catch (e) {
      print("❌ Error adding event: $e");
      rethrow;
    }
  }

  /// ✅ جلب جميع الأحداث مرتبة من الأحدث للأقدم
  static Stream<QuerySnapshot> getAllEvents() {
    return FirebaseFirestore.instance
        .collection(eventsCollection)
    // مطلوب لترتيب وعرض الأحداث بشكل سليم في HomeTab
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  /// ✅ جلب الأحداث حسب الفئة
  static Stream<QuerySnapshot> getEventsByCategory(String category) {
    if (category.toLowerCase() == "all") {
      return getAllEvents();
    }
    // ملاحظة: يُفضل استخدام القيمة منخفضة الحروف في الاستعلام أيضاً
    return FirebaseFirestore.instance
        .collection(eventsCollection)
        .where("category", isEqualTo: category.toLowerCase())
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

// يمكن إضافة دوال أخرى هنا مثل:
// static Future<void> updateEvent(...)
// static Future<void> deleteEvent(String eventId)
}