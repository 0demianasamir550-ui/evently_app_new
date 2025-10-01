import 'package:evently_app_new/l10n/app_localizations.dart';
import 'package:evently_app_new/providers/app_language_provider.dart';
import 'package:evently_app_new/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:evently_app_new/utils/app_colors.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          InkWell(
            onTap: () {
              languageProvider.changeLanguage('en');
            },
            child: languageProvider.appLanguage == 'en'
                ? getSelectedItemWidget(
              language: AppLocalizations.of(context)!.english,
            )
                : getUnselectedItemWidget(
              language: AppLocalizations.of(context)!.english,
            ),
          ),
          SizedBox(height: height * 0.02),

          InkWell(
            onTap: () {
              languageProvider.changeLanguage('ar');
            },
            child: languageProvider.appLanguage == 'ar'
                ? getSelectedItemWidget(
              language: AppLocalizations.of(context)!.arabic,
            )
                : getUnselectedItemWidget(
              language: AppLocalizations.of(context)!.arabic,
            ),
          ),
        ],
      ),
    );
  }


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


  Widget getUnselectedItemWidget({required String language}) {
    return Text(
      language,
      style: AppStyles.bold16Black,
    );
  }
}