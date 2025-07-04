import 'package:flutter/material.dart';

import '../../../export.dart';

class LanguageDirection extends StatelessWidget {
  const LanguageDirection({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: LocaleSettings.currentLocale == AppLocale.en
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: child);
  }
}
