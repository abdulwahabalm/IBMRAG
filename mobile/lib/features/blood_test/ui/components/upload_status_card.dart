import 'package:flutter/material.dart';
import 'package:mobile/core/icons/ionicons.dart';
import 'package:mobile/core/theme/theme_extensions.dart';
import 'package:mobile/core/widgets/app_surface.dart';
import 'package:mobile/features/blood_test/state/blood_test_upload_state.dart';

class UploadStatusCard extends StatelessWidget {
  const UploadStatusCard({super.key, required this.state});

  final BloodTestUploadState state;

  @override
  Widget build(BuildContext context) {
    final String title = switch (state.step) {
      UploadPreviewStep.waitingForFile => 'Waiting for a report',
      UploadPreviewStep.readyToAnalyze => 'Ready to analyze',
      UploadPreviewStep.analyzing => 'Reading biomarkers',
      UploadPreviewStep.analysisReady => 'Analysis ready',
    };
    final String detail = switch (state.step) {
      UploadPreviewStep.waitingForFile =>
        'Attach a PDF or image to preview the analysis flow.',
      UploadPreviewStep.readyToAnalyze =>
        'The mock file is staged. Run the analysis to see the result state.',
      UploadPreviewStep.analyzing =>
        'Extracting values, comparing ranges, and drafting recommendations.',
      UploadPreviewStep.analysisReady =>
        'Recommendations are prepared from mock data for this prototype.',
    };
    final IconData icon = switch (state.step) {
      UploadPreviewStep.waitingForFile => Ionicons.cloud_upload_outline,
      UploadPreviewStep.readyToAnalyze => Ionicons.document_text_outline,
      UploadPreviewStep.analyzing => Ionicons.pulse_outline,
      UploadPreviewStep.analysisReady => Ionicons.checkmark_circle,
    };

    return AppSurface(
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.colours.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              width: 42,
              height: 42,
              child: Icon(icon, color: context.colours.primary, size: 21),
            ),
          ),
          SizedBox(width: context.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.textTheme.titleMedium),
                SizedBox(height: context.spacing.xs),
                Text(detail, style: context.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
