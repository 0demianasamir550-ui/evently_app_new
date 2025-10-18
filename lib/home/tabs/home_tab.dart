import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app_new/providers/app_theme.dart';
import 'package:evently_app_new/providers/app_language_provider.dart';
import 'package:evently_app_new/l10n/app_localizations.dart';
import 'package:evently_app_new/events/event_details.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;
  final Set<String> favoriteEvents = {};

  final List<String> categories = [
    "all",
    "sport",
    "birthday",
    "meeting",
    "gaming",
    "eating",
    "holiday",
    "exhibition",
    "workshop",
    "bookclub"
  ];

  final List<IconData> icons = [
    Icons.apps,
    Icons.sports_soccer,
    Icons.cake,
    Icons.meeting_room,
    Icons.sports_esports,
    Icons.restaurant,
    Icons.beach_access,
    Icons.palette,
    Icons.handyman,
    Icons.menu_book,
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
      "Meeting",
      "Gaming",
      "Eating",
      "Holiday",
      "Exhibition",
      "Workshop",
      "Bookclub",
    ];

    Color headerColor = isDark ? const Color(0xFF101127) : const Color(0xFF5669FF);
    Color scaffoldBg = isDark ? const Color(0xFF101127) : Colors.white;
    const mainColor = Color(0xFF5669FF);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ======= HEADER =======
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 16),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.welcome_back,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        loc.user_name,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
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
                const SizedBox(height: 16),
                SizedBox(
                  height: 55,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: translatedCategories.length,
                    itemBuilder: (c, i) {
                      bool sel = selectedIndex == i;
                      Color capsuleBg = isDark
                          ? (sel ? mainColor : const Color(0xFF101127))
                          : (sel ? Colors.white : mainColor);
                      Color capsuleText = isDark ? Colors.white : (sel ? mainColor : Colors.white);
                      Color capsuleBorder = isDark ? mainColor : (sel ? mainColor : Colors.white);

                      return GestureDetector(
                        onTap: () => setState(() => selectedIndex = i),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: capsuleBg,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: capsuleBorder, width: 1.5),
                          ),
                          child: Row(
                            children: [
                              Icon(icons[i], color: capsuleText, size: 22),
                              const SizedBox(width: 8),
                              Text(
                                translatedCategories[i],
                                style: TextStyle(
                                  color: capsuleText,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // ======= EVENTS LIST =======
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('events').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No events found", style: TextStyle(fontSize: 16, color: Colors.grey)),
                  );
                }

                final events = snapshot.data!.docs.where((doc) {
                  if (selectedIndex == 0) return true;
                  final eventCategory = (doc['category'] ?? '').toString().toLowerCase().trim();
                  final selectedCategory = categories[selectedIndex].toLowerCase();
                  return eventCategory == selectedCategory;
                }).toList();

                if (events.isEmpty) {
                  return const Center(
                    child: Text("No events in this category", style: TextStyle(fontSize: 16, color: Colors.grey)),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    final data = event.data() as Map<String, dynamic>;
                    final eventId = event.id;
                    final isFavorite = favoriteEvents.contains(eventId);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EventDetailsPage(
                              title: data['title'] ?? '',
                              description: data['description'] ?? '',
                              date: (data['date'] as Timestamp).toDate(),
                              time: TimeOfDay(
                                hour: int.parse((data['time'] ?? '00:00').split(':')[0]),
                                minute: int.parse((data['time'] ?? '00:00').split(':')[1]),
                              ),
                              location: data['location'] ?? '',
                              eventId: eventId,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: mainColor, width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    topRight: Radius.circular(18),
                                  ),
                                  child: data['image'] != null && data['image'] != ""
                                      ? Image.network(data['image'], width: double.infinity, height: 180, fit: BoxFit.cover)
                                      : Image.asset("assets/images/bookclub.png", width: double.infinity, height: 180, fit: BoxFit.cover),
                                ),
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      data['time'] ?? '',
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 12,
                                  left: 12,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isFavorite) {
                                          favoriteEvents.remove(eventId);
                                        } else {
                                          favoriteEvents.add(eventId);
                                        }
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        isFavorite ? Icons.favorite : Icons.favorite_border,
                                        color: isFavorite ? Colors.red : mainColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['title'] ?? 'No Title', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: mainColor)),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on, color: mainColor, size: 20),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          data['location'] ?? 'Unknown place',
                                          style: const TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
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