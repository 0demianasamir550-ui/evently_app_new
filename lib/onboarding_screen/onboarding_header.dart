import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // المربع مع اللوجو
        Positioned(
          top: 47.18,
          left: 114.18,
          width: 53.65,
          height: 55.41,
          child: Image.asset(
            'assets/images/logo_splash_screen.png',
            fit: BoxFit.cover,
            color: const Color(0xFF5669FF),
            colorBlendMode: BlendMode.srcIn,
          ),
        ),

        // كلمة Evently
        Positioned(
          top: 65.0,
          left: 175,
          width: 101,
          height: 50,
          child: Text(
            'Evently',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Jockey One',
              fontWeight: FontWeight.w400,
              fontSize: 28,
              height: 1.0,
              letterSpacing: -0.3,
              color: Color(0xFF5669FF),
            ),
          ),
        ),
      ],
    );
  }
}