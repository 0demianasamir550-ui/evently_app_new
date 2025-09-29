import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently_app_new/providers/app_theme.dart';
import 'package:evently_app_new/providers/app_language_provider.dart';
import 'package:evently_app_new/home/tabs/profile/profile_tab.dart';
import 'package:evently_app_new/home/tabs/profile/favorite_tab.dart';
import 'package:evently_app_new/home/tabs/home_tab.dart';
import 'package:evently_app_new/events/create_event.dart'; // ✅ صفحة CreateEventPage

class MyAppWidget extends StatefulWidget {
  const MyAppWidget({super.key});
  @override
  State<MyAppWidget> createState() => _MyAppWidgetState();
}

class _MyAppWidgetState extends State<MyAppWidget> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomeTab(),
    const Center(child: Text("Map")),
    const FavoriteTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppThemeProvider>(context);
    final lang = Provider.of<AppLanguageProvider>(context);
    final isDark = theme.isDarkMode();

    final navItems = [
      {"icon": "assets/images/icon_home.png", "label": lang.appLanguage=='ar'?"الرئيسية":"Home"},
      {"icon": "assets/images/icon_map.png", "label": lang.appLanguage=='ar'?"الخريطة":"Map"},
      {"icon": "assets/images/icon_favorite.png", "label": lang.appLanguage=='ar'?"المفضلة":"Favorite"},
      {"icon": "assets/images/icon_profile.png", "label": lang.appLanguage=='ar'?"الملف الشخصي":"Profile"},
    ];

    Widget navIcon(int i) {
      final item = navItems[i];
      final selected = selectedIndex == i;

      return GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = i;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? Colors.white : Colors.transparent,
                border: Border.all(
                  color: selected ? Colors.white : Colors.white70,
                  width: 2,
                ),
              ),
              child: Image.asset(
                item["icon"]!,
                width: 28,
                height: 28,
                color: selected ? Colors.blue : (isDark ? Colors.white70 : Colors.black54),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item["label"]!,
              style: TextStyle(
                fontSize: 12,
                color: selected ? Colors.white : (isDark ? Colors.white70 : Colors.black54),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? Colors.black87 : Colors.white,
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: isDark ? const Color(0xFF101127) : const Color(0xFF5669FF),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [navIcon(0), const SizedBox(width: 30), navIcon(1)]),
                Row(children: [navIcon(2), const SizedBox(width: 30), navIcon(3)]),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  CreateEventPage()), // ✅ استدعاء CreateEventPage
                );
              },
              child: Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? const Color(0xFF101127) : const Color(0xFF5669FF),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 32),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}