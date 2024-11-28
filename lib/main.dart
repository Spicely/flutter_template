import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'app/data/theme/theme_custom.dart';
import 'app/routes/app_pages.dart';
import 'generated/l10n.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      theme: ThemeCustom.light,
      darkTheme: ThemeCustom.dark,
      // themeMode: ThemeMode.system,
      themeMode: ThemeMode.dark,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      localeListResolutionCallback: (locales, supportedLocales) {
        debugPrint('当前系统语言环境$locales');
        return;
      },
      getPages: AppPages.routes,
    ),
  );
}
