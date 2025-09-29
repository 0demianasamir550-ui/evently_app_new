import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently_app_new/providers/app_theme.dart';
import 'package:evently_app_new/providers/app_language_provider.dart';
import 'package:evently_app_new/l10n/app_localizations.dart';
import 'package:evently_app_new/onboarding_screen/onboarding2.dart'; // استيراد الصفحة الثانية

// import بالـ alias علشان نتفادى أي تضارب بأسماء الويجتس
import '../home/widgets/language_toggle.dart' as lang_widget;
import '../home/widgets/theme_toggle.dart' as theme_widget;

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
    final langProvider = Provider.of<AppLanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onboarding Page 1',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.isDarkMode() ? ThemeMode.dark : ThemeMode.light,
      locale: Locale(langProvider.appLanguage), // ربط اللغة بالـ provider
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const OnboardingScreen1(),
    );
  }
}

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var langProvider = Provider.of<AppLanguageProvider>(context);
    final loc = AppLocalizations.of(context)!;

    final bool isEnglish = langProvider.appLanguage == 'en';

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: themeProvider.isDarkMode() ? Colors.black : Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo_splash_screen.png',
                  width: 54,
                  height: 55,
                  color: const Color(0xFF5669FF),
                  colorBlendMode: BlendMode.srcIn,
                ),
                const SizedBox(width: 10),
                Text(
                  loc.evently,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Jockey One',
                    fontWeight: FontWeight.w400,
                    fontSize: 36,
                    height: 1.0,
                    letterSpacing: -0.3,
                    color: Color(0xFF5669FF),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
            Center(
              child: Image.asset(
                themeProvider.isDarkMode()
                    ? 'assets/images/image_one_dark.png'
                    : 'assets/images/image_one.png',
                width: 261,
                height: 361,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),
            Text(
              loc.personalize_experience,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                height: 1.0,
                letterSpacing: 0,
                color: Color(0xFF5669FF),
              ),
            ),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                loc.choose_preferred_theme,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 1.5,
                  color: themeProvider.isDarkMode() ? Colors.white : Colors.black,
                ),
              ),
            ),

            const Spacer(),

            // 🔹 Language row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: isEnglish
                    ? [
                  Text(
                    loc.language,
                    style: const TextStyle(
                      color: Color(0xFF5669FF),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  lang_widget.LanguageToggle(
                    selectedLanguage: langProvider.appLanguage,
                    onChanged: (lang) {
                      langProvider.changeLanguage(lang);
                    },
                  ),
                ]
                    : [
                  lang_widget.LanguageToggle(
                    selectedLanguage: langProvider.appLanguage,
                    onChanged: (lang) {
                      langProvider.changeLanguage(lang);
                    },
                  ),
                  Text(
                    loc.language,
                    style: const TextStyle(
                      color: Color(0xFF5669FF),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Theme row (التعديل لحل الايرور)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: isEnglish
                    ? [
                  Text(
                    loc.theme,
                    style: const TextStyle(
                      color: Color(0xFF5669FF),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  theme_widget.ThemeToggle(
                    isDark: themeProvider.isDarkMode(),
                    onChanged: (dark) {
                      themeProvider.changeTheme(dark ? ThemeMode.dark : ThemeMode.light);
                    },
                  ),
                ]
                    : [
                  theme_widget.ThemeToggle(
                    isDark: themeProvider.isDarkMode(),
                    onChanged: (dark) {
                      themeProvider.changeTheme(dark ? ThemeMode.dark : ThemeMode.light);
                    },
                  ),
                  Text(
                    loc.theme,
                    style: const TextStyle(
                      color: Color(0xFF5669FF),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnboardingScreen2(),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5669FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      loc.lets_start,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}