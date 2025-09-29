import 'package:evently_app_new/authentication/widgets/custominputfiled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently_app_new/providers/app_theme.dart';
import 'package:evently_app_new/providers/app_language_provider.dart';
import 'package:evently_app_new/l10n/app_localizations.dart';
import 'login_light.dart';
import '../home/widgets/language_toggle.dart'; // ✅ استدعاء لغة

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppThemeProvider, AppLanguageProvider>(
      builder: (context, themeProvider, languageProvider, child) {
        final isDark = themeProvider.isDarkMode();
        final loc = AppLocalizations.of(context)!;
        final backgroundColor = isDark ? const Color(0xFF101127) : Colors.white;
        final appBarColor = backgroundColor;
        final logoColor = const Color(0xFF5669FF);
        final iconColor = isDark ? Colors.white : const Color(0xFF7B7B7B);
        final textColor = isDark ? Colors.white : const Color(0xFF7B7B7B);

        // Controllers
        final nameController = TextEditingController();
        final emailController = TextEditingController();
        final passwordController = TextEditingController();
        final rePasswordController = TextEditingController();

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // AppBar وهمي
                SizedBox(width: double.infinity, height: 48, child: Container(color: appBarColor)),
                const SizedBox(height: 8),
                // Header السهم + Register
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginPage()),
                          );
                        },
                        child: const Icon(Icons.arrow_back, size: 28, color: Color(0xFF5669FF)),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            loc.register,
                            style: const TextStyle(
                              fontFamily: "Jockey One",
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                              color: Color(0xFF5669FF),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 28),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // المربع مع الصورة
                Center(
                  child: SizedBox(
                    width: 152,
                    height: 157,
                    child: Image.asset(
                      "assets/images/logo_splash_screen.png",
                      color: logoColor,
                      colorBlendMode: BlendMode.srcIn,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  loc.evently,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Jockey One",
                    fontWeight: FontWeight.w400,
                    fontSize: 36,
                    height: 1.0,
                    letterSpacing: -0.3,
                    color: Color(0xFF5669FF),
                  ),
                ),
                const SizedBox(height: 24),
                // المستطيلات الأربعة
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      CustomInputField(
                        controller: nameController,
                        hintText: loc.name,
                        prefixIcon: Icons.person,
                      ),
                      const SizedBox(height: 16),
                      CustomInputField(
                        controller: emailController,
                        hintText: loc.email,
                        prefixIcon: Icons.email,
                      ),
                      const SizedBox(height: 16),
                      CustomInputField(
                        controller: passwordController,
                        hintText: loc.password,
                        obscureText: true,
                        prefixIcon: Icons.lock,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.visibility_off),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomInputField(
                        controller: rePasswordController,
                        hintText: loc.re_password,
                        obscureText: true,
                        prefixIcon: Icons.lock,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.visibility_off),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // زر Create Account
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5669FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          loc.create_account,
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Already Have Account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loc.already_have_account,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            loc.login,
                            style: const TextStyle(
                              color: Color(0xFF5669FF),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Divider(color: Color(0xFF5669FF), thickness: 2, height: 0),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ✅ Language Toggle
                LanguageToggle(
                  selectedLanguage: languageProvider.appLanguage,
                  onChanged: (lang) {
                    languageProvider.changeLanguage(lang);
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
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
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const RegisterPage(),
    );
  }
}