import 'package:flutter/material.dart';
import 'package:mobile/core/icons/ionicons.dart';
import 'package:mobile/core/theme/theme_extensions.dart';
import 'package:mobile/core/widgets/app_surface.dart';

class UploadDropZone extends StatelessWidget {
  const UploadDropZone({
    super.key,
    required this.title,
    required this.subtitle,
    required this.actionIcon,
    required this.onTap,
    this.isActive = false,
  });

  final String title;
  final String subtitle;
  final IconData actionIcon;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AppSurface(
        color: isActive
            ? context.colours.surfaceRaised
            : context.colours.surface,
        borderColor: isActive
            ? context.colours.primary.withValues(alpha: 0.26)
            : context.colours.border,
        padding: EdgeInsets.all(context.spacing.xl),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: context.colours.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                width: 58,
                height: 58,
                child: Icon(
                  Ionicons.document_text_outline,
                  color: context.colours.primary,
                  size: 28,
                ),
              ),
            ),
            SizedBox(width: context.spacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.textTheme.titleMedium),
                  SizedBox(height: context.spacing.xs),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Icon(actionIcon, color: context.colours.primaryDark, size: 24),
          ],
        ),
      ),
    );
  }
}
