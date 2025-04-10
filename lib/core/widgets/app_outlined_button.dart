import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final Widget? icon;
  final ButtonStyle? style;
  final double? width;
  final double? height;

  const AppOutlinedButton({
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

    final defaultStyle = OutlinedButton.styleFrom(
      foregroundColor: theme.colorScheme.primary,
      // Màu chữ/icon khi enabled
      // Màu viền
      side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
      disabledForegroundColor: theme.colorScheme.onSurface.withOpacity(0.38),
      disabledMouseCursor: SystemMouseCursors.forbidden,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      textStyle:
          theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
    ).copyWith(
      side: MaterialStateProperty.resolveWith<BorderSide?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return BorderSide(
              color: theme.colorScheme.onSurface.withOpacity(0.12),
              width: 1.5,
            );
          }
          return BorderSide(color: theme.colorScheme.primary, width: 1.5);
        },
      ),
      minimumSize: MaterialStateProperty.all(Size(width ?? 0, height ?? 48)),
      maximumSize: MaterialStateProperty.all(
          Size(width ?? double.infinity, height ?? 48)),
    );
    final buttonContent = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor:
                  AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
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

    return OutlinedButton(
      style: style ?? defaultStyle,
      onPressed: effectiveOnPressed,
      child: buttonContent,
    );
  }
}
