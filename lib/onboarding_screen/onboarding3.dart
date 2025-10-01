import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently_app_new/providers/app_theme.dart';
import 'package:evently_app_new/l10n/app_localizations.dart';
import 'onboarding2.dart';
import 'onboarding4.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    final loc = AppLocalizations.of(context)!;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode() ? Colors.black : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

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
                  themeProvider.isDarkMode()
                      ? 'assets/images/image_three_dark.png'
                      : 'assets/images/image_three.png',
                  width: 261,
                  height: 361,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),


              Text(
                loc.effortless_event_planning,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  letterSpacing: 0,
                  height: 1.0,
                  color: Color(0xFF5669FF),
                ),
              ),

              const SizedBox(height: 25),


              Text(
                loc.take_the_hassle_out_of_organizing,
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
                  bool isActive = index == 1;
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
                            builder: (context) => const OnboardingScreen2()),
                      );
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                        Border.all(color: const Color(0xFF5669FF), width: 2),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OnboardingScreen4()),
                      );
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                        Border.all(color: const Color(0xFF5669FF), width: 2),
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