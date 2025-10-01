// lib/authentication/login_light.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently_app_new/providers/app_theme.dart';
import 'package:evently_app_new/providers/app_language_provider.dart';
import 'package:evently_app_new/l10n/app_localizations.dart';
import 'register_light.dart';
import 'forget_password_light.dart';
import 'package:evently_app_new/home/home_screen.dart';
import 'package:evently_app_new/home/widgets/language_toggle.dart';

class CustomBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final double borderWidth;
  final Widget? child;

  const CustomBox({
    super.key,
    this.width = 361,
    this.height = 56,
    this.borderRadius = 16,
    this.borderWidth = 1,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.brightness == Brightness.dark
        ? const Color(0xFF5669FF)
        : const Color(0xFF7B7B7B);

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: child,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  void handleLogin(AppLocalizations loc) {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.fill_all_fields)),
      );
      return;
    }

    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.invalid_email)),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MyAppWidget()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppThemeProvider, AppLanguageProvider>(
      builder: (context, themeProvider, languageProvider, child) {
        final isDark = themeProvider.isDarkMode();
        final loc = AppLocalizations.of(context)!;

        final backgroundColor = isDark ? const Color(0xFF101127) : Colors.white;
        final logoColor = const Color(0xFF5669FF);
        final textColor = isDark ? Colors.white : const Color(0xFF7B7B7B);

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: Container(color: backgroundColor),
                  ),
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 20),
                  CustomBox(
                    child: Row(
                      children: [
                        Icon(Icons.email, color: textColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: loc.email,
                              hintStyle: TextStyle(color: textColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomBox(
                    child: Row(
                      children: [
                        Icon(Icons.lock, color: textColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: loc.password,
                              hintStyle: TextStyle(color: textColor),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          child: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: isDark ? Colors.white : Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ForgetPasswordPage()),
                          );
                        },
                        child: Text(
                          loc.forget_password,
                          style: const TextStyle(
                            color: Color(0xFF5669FF),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 361,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => handleLogin(loc),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5669FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        loc.login,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loc.dont_have_account,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const RegisterPage()),
                          );
                        },
                        child: Text(
                          loc.create_account,
                          style: const TextStyle(
                            color: Color(0xFF5669FF),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 16, right: 8),
                          height: 1,
                          color: const Color(0xFF5669FF),
                        ),
                      ),
                      Text(
                        loc.or,
                        style: const TextStyle(color: Color(0xFF5669FF)),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 8, right: 16),
                          height: 1,
                          color: const Color(0xFF5669FF),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 361,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint('Login with Google');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: Color(0xFF5669FF)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/google_icon.png', width: 24, height: 24),
                          const SizedBox(width: 8),
                          Text(
                            loc.login_with_google,
                            style: const TextStyle(
                              color: Color(0xFF5669FF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
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
          ),
        );
      },
    );
  }
}