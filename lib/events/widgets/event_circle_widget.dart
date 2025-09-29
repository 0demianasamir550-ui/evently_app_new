import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:evently_app_new/l10n/app_localizations.dart';
import 'package:evently_app_new/providers/app_language_provider.dart';
import 'package:evently_app_new/providers/app_theme.dart';

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
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF101127),
      ),
      themeMode: themeProvider.isDarkMode() ? ThemeMode.dark : ThemeMode.light,
      locale: Locale(languageProvider.appLanguage),
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
      home: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: EventCategoriesList(),
          ),
        ),
      ),
    );
  }
}

// ---------------- Event Oval ----------------
class EventOvalLarge extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final bool isDark;

  const EventOvalLarge({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final Color contentColor = isSelected
        ? (isDark ? Colors.black : Colors.white)
        : const Color(0xFF5669FF);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF5669FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(37),
        border: Border.all(color: const Color(0xFF5669FF), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: contentColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: contentColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Event Categories List ----------------
class EventCategoriesList extends StatefulWidget {
  const EventCategoriesList({super.key});

  @override
  State<EventCategoriesList> createState() => _EventCategoriesListState();
}

class _EventCategoriesListState extends State<EventCategoriesList> {
  int selectedIndex = 0; // افتراضي bookclub
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final isDark = themeProvider.isDarkMode();

    final categories = [
      {
        "icon": Icons.menu_book,
        "label": localizations.category_bookClub,
        "image": "assets/images/bookclub.png"
      },
      {
        "icon": Icons.directions_bike,
        "label": localizations.category_sport,
        "image": "assets/images/sport.png"
      },
      {
        "icon": Icons.cake,
        "label": localizations.category_birthday,
        "image": "assets/images/birthday.png"
      },
      {
        "icon": Icons.work,
        "label": localizations.category_meeting,
        "image": "assets/images/meeting.png"
      },
      {
        "icon": Icons.videogame_asset,
        "label": localizations.category_gaming,
        "image": "assets/images/gaming.png"
      },
      {
        "icon": Icons.handyman,
        "label": localizations.category_workshop,
        "image": "assets/images/workshop.png"
      },
      {
        "icon": Icons.museum,
        "label": localizations.category_exhibition,
        "image": "assets/images/exhibition.png"
      },
      {
        "icon": Icons.beach_access,
        "label": localizations.category_holiday,
        "image": "assets/images/holiday.png"
      },
      {
        "icon": Icons.restaurant,
        "label": localizations.category_eating,
        "image": "assets/images/eating.png"
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        // -------- الصورة --------
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              categories[selectedIndex]["image"] as String,
              width: 361,
              height: 203,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // -------- قائمة الدوائر --------
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.asMap().entries.map((entry) {
              int idx = entry.key;
              Map category = entry.value;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = idx;
                    });
                  },
                  child: EventOvalLarge(
                    icon: category["icon"] as IconData,
                    label: category["label"] as String,
                    isSelected: selectedIndex == idx,
                    isDark: isDark,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}