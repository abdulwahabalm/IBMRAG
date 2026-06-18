import 'package:flutter/material.dart';
import 'package:mobile/core/icons/ionicons.dart';
import 'package:mobile/core/theme/theme_extensions.dart';
import 'package:mobile/core/widgets/app_surface.dart';
import 'package:mobile/features/blood_test/data/models/blood_test_analysis.dart';

class AnalysisSummaryCard extends StatelessWidget {
  const AnalysisSummaryCard({super.key, required this.analysis});

  final BloodTestAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Ionicons.sparkles, color: context.colours.primary, size: 20),
              SizedBox(width: context.spacing.sm),
              Text('AI analysis', style: context.textTheme.titleMedium),
              const Spacer(),
              Text(
                analysis.confidence,
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colours.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: context.spacing.md),
          Text(analysis.summary, style: context.textTheme.bodyLarge),
        ],
      ),
    );
  }
}
