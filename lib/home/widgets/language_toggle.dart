import 'package:flutter/material.dart';

class LanguageToggle extends StatelessWidget {
  final String selectedLanguage;
  final ValueChanged<String> onChanged;

  const LanguageToggle({
    super.key,
    required this.selectedLanguage,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 73.28,
      height: 30.76,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF5669FF), width: 2),
        borderRadius: BorderRadius.circular(30.76 / 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLanguageOption("en", "🇺🇸"),
          const SizedBox(width: 8),
          _buildLanguageOption("ar", "🇪🇬"),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String lang, String flag) {
    bool isSelected = selectedLanguage == lang;
    return GestureDetector(
      onTap: () => onChanged(lang),
      child: Container(
        width: 21.71,
        height: 21.71,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? const Color(0xFF5669FF) : Colors.transparent,
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(flag, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}