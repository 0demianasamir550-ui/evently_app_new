import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onChanged;

  const ThemeToggle({
    super.key,
    required this.isDark,
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
          _buildThemeOption(false, Icons.wb_sunny),
          const SizedBox(width: 8),
          _buildThemeOption(true, Icons.nightlight_round),
        ],
      ),
    );
  }

  Widget _buildThemeOption(bool dark, IconData icon) {
    bool isSelected = isDark == dark;
    return GestureDetector(
      onTap: () => onChanged(dark),
      child: Container(
        width: 21.71,
        height: 21.71,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? const Color(0xFF5669FF) : Colors.grey[300],
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 14,
          color: isSelected ? Colors.white : const Color(0xFF5669FF),
        ),
      ),
    );
  }
}