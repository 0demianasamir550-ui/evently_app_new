import 'package:evently_app_new/l10n/app_localizations.dart';
import 'package:evently_app_new/providers/app_language_provider.dart';
import 'package:evently_app_new/providers/app_theme.dart';
import 'package:evently_app_new/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:evently_app_new/utils/app_colors.dart';
import 'package:provider/provider.dart';

class themeBottomSheet extends StatefulWidget {
  const themeBottomSheet({super.key});

  @override
  State<themeBottomSheet> createState() => _themeBottomSheetState();
}

class _themeBottomSheetState extends State<themeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // ياخد مساحة المحتوى بس
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // English
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child: themeProvider.isDarkMode()?
            getSelectedItemWidget(
              language: AppLocalizations.of(context)!.dark,
            )
                : getUnselectedItemWidget(
              language: AppLocalizations.of(context)!.dark,
            ),
          ),
          SizedBox(height: height * 0.02),
          // Arabic
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.light);
            },
            child: !(themeProvider.isDarkMode())
                ? getSelectedItemWidget(
              language: AppLocalizations.of(context)!.light,
            )
                : getUnselectedItemWidget(
              language: AppLocalizations.of(context)!.light,
            ),
          ),
        ],
      ),
    );
  }

  /// العنصر المختار (مع العلامة ✓)
  Widget getSelectedItemWidget({required String language}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          language,
          style: AppStyles.bold16Primary,
        ),
        Icon(
          Icons.check,
          size: 30,
          color: AppColors.primaryLight,
        ),
      ],
    );
  }

  /// العنصر الغير مختار (من غير علامة ✓)
  Widget getUnselectedItemWidget({required String language}) {
    return Text(
      language,
      style: AppStyles.bold16Black,
    );
  }
}