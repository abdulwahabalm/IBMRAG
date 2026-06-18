import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_theme.dart';

extension AppThemeContext on BuildContext {
  AppColours get colours => Theme.of(this).extension<AppColours>()!;
  AppSpacing get spacing => Theme.of(this).extension<AppSpacing>()!;
  AppRadius get radius => Theme.of(this).extension<AppRadius>()!;
  TextTheme get textTheme => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
}
