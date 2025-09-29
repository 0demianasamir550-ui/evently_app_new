import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently_app_new/providers/app_theme.dart';
import 'package:evently_app_new/providers/app_language_provider.dart';
import 'package:evently_app_new/l10n/app_localizations.dart';

import '../widgets/event_card_widget.dart'; // ✅ ملف الـ widget

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;
  final List<String> categories = ["all", "sport", "birthday", "sport"];
  final List<String> images = [
    "assets/images/Compass.png",
    "assets/images/bike.png",
    "assets/images/cake.png",
    "assets/images/bike.png",
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final languageProvider = Provider.of<AppLanguageProvider>(context);
    final isDark = themeProvider.isDarkMode();
    final loc = AppLocalizations.of(context)!;

    List<String> translatedCategories = [
      loc.all,
      loc.sport,
      loc.birthday,
      loc.sport,
    ];

    Color headerColor = isDark ? const Color(0xFF101127) : const Color(0xFF5669FF);
    Color scaffoldBg = isDark ? const Color(0xFF101127) : Colors.white;

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 16),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(loc.welcome_back,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(loc.user_name,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                    Row(
                      children: [
                        // أيقونة الشمس
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => _themeBottomSheet(themeProvider),
                            );
                          },
                          child: Image.asset(
                            'assets/images/Sun.png',
                            width: 35,
                            height: 35,
                          ),
                        ),
                        const SizedBox(width: 10),
                        // المربع الخاص باللغة
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => _languageBottomSheet(languageProvider),
                            );
                          },
                          child: Container(
                            width: 35,
                            height: 33,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isDark ? Colors.white : const Color(0xFF5669FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              languageProvider.appLanguage.toUpperCase(),
                              style: TextStyle(
                                color: isDark ? Colors.black : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white, size: 18),
                    const SizedBox(width: 4),
                    Text(loc.location,
                        style: const TextStyle(fontSize: 14, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 16),
                // Capsules
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: translatedCategories.length,
                    itemBuilder: (c, i) {
                      bool sel = selectedIndex == i;

                      Color capsuleBg;
                      Color capsuleText;
                      Color capsuleBorder;

                      if (isDark) {
                        capsuleBg = sel ? const Color(0xFF5669FF) : const Color(0xFF101127);
                        capsuleText = Colors.white;
                        capsuleBorder = const Color(0xFF5669FF);
                      } else {
                        capsuleBg = sel ? Colors.white : const Color(0xFF5669FF);
                        capsuleText = sel ? const Color(0xFF5669FF) : Colors.white;
                        capsuleBorder = sel ? const Color(0xFF5669FF) : Colors.white;
                      }

                      return GestureDetector(
                        onTap: () => setState(() => selectedIndex = i),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: capsuleBg,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: capsuleBorder, width: 1.5),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                images[i],
                                width: 20,
                                height: 20,
                                color: capsuleText,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                translatedCategories[i],
                                style: TextStyle(
                                    color: capsuleText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Content (Cards بدل النص الفاضي)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  EventCardWidget(
                    imagePath: "assets/images/birthday.png",
                    number: "21",
                    label: "Now",
                    textLabel: "Birthday Party",
                  ),
                  const SizedBox(height: 16),
                  EventCardWidget(
                    imagePath: "assets/images/meeting.png",
                    number: "22",
                    label: "Now",
                    textLabel: "Business Meeting",
                  ),
                  const SizedBox(height: 16),
                  EventCardWidget(
                    imagePath: "assets/images/exhibition.png",
                    number: "23",
                    label: "Now",
                    textLabel: "Art Exhibition",
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _languageBottomSheet(AppLanguageProvider languageProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('EN'),
            onTap: () {
              languageProvider.changeLanguage('en');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('AR'),
            onTap: () {
              languageProvider.changeLanguage('ar');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _themeBottomSheet(AppThemeProvider themeProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Light'),
            onTap: () {
              themeProvider.changeTheme(ThemeMode.light);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Dark'),
            onTap: () {
              themeProvider.changeTheme(ThemeMode.dark);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

// ==================== main ====================
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
      locale: Locale(languageProvider.appLanguage),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const HomeTab(),
    );
  }
}