import 'package:flutter/material.dart';
import 'package:mobile/core/icons/ionicons.dart';
import 'package:mobile/core/theme/theme_extensions.dart';

class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon = Ionicons.arrow_forward,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: onPressed == null || isLoading
            ? context.colours.primary.withValues(alpha: 0.45)
            : context.colours.primary,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(context.radius.lg),
        ),
      ),
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              else
                Icon(icon, size: 19, color: Colors.white),
              SizedBox(width: context.spacing.sm),
              Text(
                label,
                style: context.textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
