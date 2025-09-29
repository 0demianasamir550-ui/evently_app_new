import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently_app_new/providers/app_theme.dart';
import 'package:evently_app_new/providers/app_language_provider.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  // حالة القلب لكل مستطيل
  List<bool> isFavorited = [false, false, false];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final languageProvider = Provider.of<AppLanguageProvider>(context);
    final isDark = themeProvider.isDarkMode();
    final isArabic = languageProvider.appLanguage == 'ar';

    // الترجمات حسب اللغة
    final searchHint = isArabic ? 'ابحث عن حدث' : 'Search for Event';
    final nowLabel = isArabic ? 'الآن' : 'Now';
    final birthdayText = isArabic ? 'هذه حفلة عيد ميلاد' : 'This is Birthday Party';
    final meetingText = isArabic ? 'اجتماع لتحديث طريقة التطوير' : 'Meeting for Updating The Development Method';

    return Scaffold(
      backgroundColor: isDark ? Colors.black87 : Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, // نزول المستطيلات قبل الـ bottom
          children: [
            const SizedBox(height: 16),

            // المستطيل الأول - Search
            Container(
              width: 361,
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF5669FF),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
              child: TextField(
                decoration: InputDecoration(
                  hintText: searchHint,
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: const Color(0xFF5669FF),
                  ),
                ),
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // المستطيلات الثلاثة
            eventCardWidget(
              index: 0,
              isDark: isDark,
              imagePath: "assets/images/holiday.png",
              number: "21",
              label: nowLabel,
              textLabel: birthdayText,
              isArabic: isArabic,
            ),
            const SizedBox(height: 16),
            eventCardWidget(
              index: 1,
              isDark: isDark,
              imagePath: "assets/images/meeting.png",
              number: "22",
              label: nowLabel,
              textLabel: meetingText,
              isArabic: isArabic,
            ),
            const SizedBox(height: 16),
            eventCardWidget(
              index: 2,
              isDark: isDark,
              imagePath: "assets/images/exhibition.png",
              number: "22",
              label: nowLabel,
              textLabel: meetingText,
              isArabic: isArabic,
            ),

            const SizedBox(height: 16), // مسافة بسيطة فوق الـ bottom
          ],
        ),
      ),
    );
  }

  Widget eventCardWidget({
    required int index,
    required bool isDark,
    required String imagePath,
    required String number,
    required String label,
    required String textLabel,
    required bool isArabic,
  }) {
    return Container(
      width: 361,
      height: 203.06,
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
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
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
                  Text(
                    number,
                    style: TextStyle(
                      color: const Color(0xFF5669FF),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      color: isDark ? Colors.white : const Color(0xFF5669FF),
                      fontSize: 12,
                    ),
                  ),
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
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      textLabel,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorited[index] = !isFavorited[index];
                      });
                    },
                    child: Icon(
                      isFavorited[index]
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isFavorited[index] ? const Color(0xFF5669FF) : Colors.grey,
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