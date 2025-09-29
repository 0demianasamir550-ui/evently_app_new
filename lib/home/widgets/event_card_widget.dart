import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../providers/app_language_provider.dart';
import '../../providers/app_theme.dart';
import 'package:evently_app_new/l10n/app_localizations.dart';


void main() {
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
      theme: themeProvider.isDarkMode() ? ThemeData.dark() : ThemeData.light(),
      locale: Locale(languageProvider.appLanguage), // 'ar' أو 'en'
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      home: const EventDemoScreen(),
    );
  }
}

// صفحة عرض المستطيلات فقط مع مساحة فارغة أعلى وأسفل
class EventDemoScreen extends StatelessWidget {
  const EventDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final isDark = themeProvider.isDarkMode();

    return Scaffold(
      backgroundColor: isDark ? Colors.black87 : Colors.white,
      body: Column(
        children: [
          // مساحة فارغة أعلى
          SizedBox(height: 40),

          // المستطيلات قابلة للتمرير
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  EventCardWidget(
                    imagePath: "assets/images/birthday.png",
                    number: "21",
                    label: AppLocalizations.of(context)!.nowLabel,
                    textLabel: AppLocalizations.of(context)!.birthdayText,
                  ),
                  const SizedBox(height: 16),
                  EventCardWidget(
                    imagePath: "assets/images/meeting.png",
                    number: "22",
                    label: AppLocalizations.of(context)!.nowLabel,
                    textLabel: AppLocalizations.of(context)!.meetingText,
                  ),
                  const SizedBox(height: 16),
                  EventCardWidget(
                    imagePath: "assets/images/exhibition.png",
                    number: "23",
                    label: AppLocalizations.of(context)!.nowLabel,
                    textLabel: AppLocalizations.of(context)!.meetingText,
                  ),
                  const SizedBox(height: 16),
                  // يمكن إضافة مستطيلات أكثر هنا
                  SizedBox(height: 80), // مساحة فارغة أسفل بدل Bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// المستطيل الواحد (EventCardWidget)
class EventCardWidget extends StatefulWidget {
  final String imagePath;
  final String number;
  final String label;
  final String textLabel;

  const EventCardWidget({
    super.key,
    required this.imagePath,
    required this.number,
    required this.label,
    required this.textLabel,
  });

  @override
  State<EventCardWidget> createState() => _EventCardWidgetState();
}

class _EventCardWidgetState extends State<EventCardWidget> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final isDark = themeProvider.isDarkMode();

    return Container(
      width: double.infinity,
      height: 203,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF5669FF), width: 1),
      ),
      child: Stack(
        children: [
          // الصورة الخلفية
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(widget.imagePath, fit: BoxFit.cover),
            ),
          ),
          // المربع الصغير بالرقم والكلمة
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: isDark ? Colors.transparent : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.number,
                      style: const TextStyle(
                          color: Color(0xFF5669FF),
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  Text(widget.label,
                      style: TextStyle(
                          color: isDark ? Colors.white : const Color(0xFF5669FF),
                          fontSize: 12)),
                ],
              ),
            ),
          ),
          // المستطيل السفلي للنص والقلب
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: isDark ? Colors.transparent : Colors.white,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(widget.textLabel,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorited = !isFavorited;
                      });
                    },
                    child: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited ? const Color(0xFF5669FF) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}