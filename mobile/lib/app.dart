import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/features/blood_test/ui/pages/blood_test_upload_page.dart';

class BloodLensApp extends StatelessWidget {
  const BloodLensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloodLens',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const BloodTestUploadPage(),
    );
  }
}
