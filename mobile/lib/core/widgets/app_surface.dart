import 'package:flutter/material.dart';
import 'package:mobile/core/theme/theme_extensions.dart';

class AppSurface extends StatelessWidget {
  const AppSurface({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: color ?? context.colours.surface,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(context.radius.lg),
          side: BorderSide(color: borderColor ?? context.colours.border),
        ),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(context.spacing.lg),
        child: child,
      ),
    );
  }
}
