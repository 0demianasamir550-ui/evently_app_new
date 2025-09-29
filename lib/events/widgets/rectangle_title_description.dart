import 'package:flutter/material.dart';
import 'package:evently_app_new/l10n/app_localizations.dart';

class RectangleTitleDescriptionWidget extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const RectangleTitleDescriptionWidget({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  State<RectangleTitleDescriptionWidget> createState() =>
      _RectangleTitleDescriptionWidgetState();
}

class _RectangleTitleDescriptionWidgetState
    extends State<RectangleTitleDescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localizations = AppLocalizations.of(context)!;

    final borderColor = isDark ? const Color(0xFF5669FF) : const Color(0xFF7B7B7B);
    final labelColor = isDark ? Colors.white : Colors.black;
    final placeholderColor = isDark ? Colors.white : const Color(0xFF7B7B7B);
    final iconColor = isDark ? Colors.white : const Color(0xFF7B7B7B);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.title,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/images/icon_title.png',
                width: 24,
                height: 24,
                color: iconColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: widget.titleController,
                  style: TextStyle(color: labelColor, fontSize: 16),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: localizations.please_enter_title,
                    hintStyle: TextStyle(color: placeholderColor, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          localizations.description,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 127,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: TextField(
            controller: widget.descriptionController,
            maxLines: null,
            expands: true,
            style: TextStyle(color: labelColor, fontSize: 16),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: localizations.please_enter_description,
              hintStyle: TextStyle(color: placeholderColor, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}