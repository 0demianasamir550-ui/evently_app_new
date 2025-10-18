import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// يجب التأكد من مسار هذه الملفات
import 'package:evently_app_new/events/widgets/event_circle_widget.dart';
import 'package:evently_app_new/events/widgets/event_date.dart';
import 'package:evently_app_new/events/widgets/event_time.dart';
import 'package:evently_app_new/events/widgets/rectangle_title_description.dart';
import 'package:evently_app_new/events/widgets/location.dart';
import 'package:evently_app_new/events/widgets/add_event_button.dart';
import 'package:evently_app_new/providers/app_theme.dart';
import 'package:evently_app_new/providers/app_language_provider.dart';
import 'package:evently_app_new/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// ملاحظة: تم إزالة استيراد FirestoreService لأنه لم يعد مستخدماً مباشرة هنا

void main() {
  // *ملاحظة:* في تطبيقك الحقيقي يجب تهيئة Firebase هنا (Firebase.initializeApp()).
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(create: (_) => AppLanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final languageProvider = Provider.of<AppLanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(languageProvider.appLanguage),
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.isDarkMode() ? ThemeMode.dark : ThemeMode.light,
      home: const CreateEventPage(),
    );
  }
}

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedLocation;

  String? selectedCategoryLabel;
  String? selectedCategoryImage; // رابط الصورة (URL) أو مسارها المحلي

  // *ملاحظة:* تم حذف _isLoading و _saveEvent

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
                      localizations.create_event,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF5669FF),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ✅ تمرير الدالة لتحديث الفئة والصورة
                EventCategoriesList(
                  onCategorySelected: (label, image) {
                    setState(() {
                      selectedCategoryLabel = label;
                      selectedCategoryImage = image;
                    });
                  },
                ),

                // *ملاحظة:* يمكنك إضافة زر لاختيار الصورة هنا وتحديث selectedCategoryImage

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

                // ✅ زرار الإضافة (بدون onPressed)
                AddEventButton(
                  titleController: titleController,
                  descriptionController: descriptionController,
                  selectedDate: selectedDate,
                  selectedTime: selectedTime,
                  selectedLocation: selectedLocation,
                  categoryLabel: selectedCategoryLabel,
                  categoryImage: selectedCategoryImage,
                  buttonText: localizations.edit_event,
                  // تم حذف onPressed لتجنب الخطأ
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