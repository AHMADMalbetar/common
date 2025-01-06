import 'package:common/common/extensions/font_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../const/app_consts.dart';
import '../helpers/shared_preferences_helper.dart';
import 'app_text.dart';

enum LanguageOptions {
  ar,
  en,
}

class AppLanguage extends StatelessWidget {
  const AppLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<LanguageOptions>(
      color: context.onPrimaryColor,
      child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 15, end: 5),
          child: AppText.bodyMedium(
            context.locale.languageCode,
            color: const Color(0xff838383),
            fontWeight: FontWeight.w500,
          )),
      onSelected: (LanguageOptions result) {
        context.setLocale(Locale(result.index == 1 ? 'en' : 'ar'));
        SharedPreferencesHelper.saveData(key: AppKeys.langNo, value: result.index);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<LanguageOptions>>[
        PopupMenuItem<LanguageOptions>(
          value: LanguageOptions.en,
          child: AppText.bodySmall(
            'EN',
            color: context.primaryColor,
          ),
        ),
        PopupMenuItem<LanguageOptions>(
          value: LanguageOptions.ar,
          child: AppText.bodySmall(
            'AR',
            color: context.primaryColor,
          ),
        ),
      ],
    );
  }
}
