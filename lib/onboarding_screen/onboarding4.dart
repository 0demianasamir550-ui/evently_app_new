import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently_app_new/providers/app_theme.dart';
import 'package:evently_app_new/l10n/app_localizations.dart';
import '../authentication/login_light.dart';
import 'onboarding3.dart';

class OnboardingScreen4 extends StatelessWidget {
  const OnboardingScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);


    String imagePath = themeProvider.isDarkMode()
        ? 'assets/images/image_four_dark.png'
        : 'assets/images/image_four.png';


    var loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode() ? Colors.black : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_splash_screen.png',
                    width: 53.65,
                    height: 55.41,
                    color: const Color(0xFF5669FF),
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    loc.evently,
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

              const SizedBox(height: 30),


              Center(
                child: Image.asset(
                  imagePath,
                  width: 261,
                  height: 361,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),


              Text(
                loc.connect_with_friends,
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


              Text(
                loc.share_moments_with_friends,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 1.5,
                  color: themeProvider.isDarkMode() ? Colors.white : Colors.black,
                ),
              ),

              const Spacer(),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  bool isActive = index == 2;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isActive ? const Color(0xFF5669FF) : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OnboardingScreen3()),
                      );
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF5669FF), width: 2),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Color(0xFF5669FF),
                          size: 28,
                        ),
                      ),
                    ),
                  ),


                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF5669FF), width: 2),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF5669FF),
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}