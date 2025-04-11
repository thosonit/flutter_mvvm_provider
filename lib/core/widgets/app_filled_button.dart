import 'package:flutter/material.dart';

class AppFilledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final Widget? icon;
  final ButtonStyle? style;
  final double? width;
  final double? height;

  const AppFilledButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.icon,
    this.style,
    this.width,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveOnPressed = isLoading ? null : onPressed;
    final defaultStyle = FilledButton.styleFrom(
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      disabledBackgroundColor:
          theme.colorScheme.onSurface.withValues(alpha: 0.12),
      disabledForegroundColor:
          theme.colorScheme.onSurface.withValues(alpha: 0.38),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      textStyle: theme.textTheme.labelLarge
          ?.copyWith(fontWeight: FontWeight.w600), // Style chữ
    ).copyWith(
      minimumSize: WidgetStateProperty.all(Size(width ?? 0, height ?? 48)),
      maximumSize:
          WidgetStateProperty.all(Size(width ?? double.infinity, height ?? 48)),
    );
    final buttonContent = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor:
                  AlwaysStoppedAnimation<Color>(theme.colorScheme.onPrimary),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 8.0),
              ],
              Flexible(
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );

    return FilledButton(
      style: style ?? defaultStyle,
      onPressed: effectiveOnPressed,
      child: buttonContent,
    );
  }
}
