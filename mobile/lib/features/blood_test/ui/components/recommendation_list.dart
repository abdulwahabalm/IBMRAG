import 'package:flutter/material.dart';
import 'package:mobile/core/theme/theme_extensions.dart';
import 'package:mobile/core/widgets/app_surface.dart';
import 'package:mobile/features/blood_test/data/models/blood_test_analysis.dart';

class RecommendationList extends StatelessWidget {
  const RecommendationList({super.key, required this.recommendations});

  final List<Recommendation> recommendations;

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recommendations', style: context.textTheme.titleMedium),
          SizedBox(height: context.spacing.md),
          for (final Recommendation recommendation in recommendations) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  recommendation.icon,
                  color: context.colours.primary,
                  size: 22,
                ),
                SizedBox(width: context.spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recommendation.title,
                        style: context.textTheme.titleMedium,
                      ),
                      SizedBox(height: context.spacing.xs),
                      Text(
                        recommendation.detail,
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (recommendation != recommendations.last)
              SizedBox(height: context.spacing.lg),
          ],
        ],
      ),
    );
  }
}
