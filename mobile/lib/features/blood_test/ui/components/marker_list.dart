import 'package:flutter/material.dart';
import 'package:mobile/core/icons/ionicons.dart';
import 'package:mobile/core/theme/theme_extensions.dart';
import 'package:mobile/core/widgets/app_surface.dart';
import 'package:mobile/features/blood_test/data/models/blood_test_analysis.dart';

class MarkerList extends StatelessWidget {
  const MarkerList({super.key, required this.markers});

  final List<BloodMarker> markers;

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Key markers', style: context.textTheme.titleMedium),
          SizedBox(height: context.spacing.md),
          for (final BloodMarker marker in markers) ...[
            MarkerTile(marker: marker),
            if (marker != markers.last) SizedBox(height: context.spacing.md),
          ],
        ],
      ),
    );
  }
}

class MarkerTile extends StatelessWidget {
  const MarkerTile({super.key, required this.marker});

  final BloodMarker marker;

  @override
  Widget build(BuildContext context) {
    final Color statusColor = switch (marker.status) {
      MarkerStatus.optimal => context.colours.success,
      MarkerStatus.attention => context.colours.warning,
      MarkerStatus.improving => context.colours.info,
    };
    final IconData statusIcon = switch (marker.status) {
      MarkerStatus.optimal => Ionicons.checkmark_circle,
      MarkerStatus.attention => Ionicons.warning_outline,
      MarkerStatus.improving => Ionicons.trending_up,
    };

    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: SizedBox(
            width: 38,
            height: 38,
            child: Icon(statusIcon, color: statusColor, size: 20),
          ),
        ),
        SizedBox(width: context.spacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(marker.name, style: context.textTheme.titleMedium),
              SizedBox(height: context.spacing.xs),
              Text(
                'Reference ${marker.range}',
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Text(marker.value, style: context.textTheme.labelLarge),
      ],
    );
  }
}
