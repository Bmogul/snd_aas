import 'package:flutter/material.dart';
import 'package:snd_aas/widgets/shared/responsive_layout.dart';

/// Reusable form field widgets that consolidate styles from login and register forms

class ResponsiveTextField extends StatelessWidget {
  const ResponsiveTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.responsiveWidth(),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
        ),
        validator: validator,
      ),
    );
  }
}

class ResponsiveButton extends StatelessWidget {
  const ResponsiveButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.style,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.responsiveWidth(),
      child: ElevatedButton(
        onPressed: onPressed,
        style: style ??
            ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
        child: Text(label),
      ),
    );
  }
}

class ResponsiveOutlinedButton extends StatelessWidget {
  const ResponsiveOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.style,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.responsiveWidth(),
      child: icon != null
          ? OutlinedButton.icon(
              onPressed: onPressed,
              icon: icon!,
              label: Text(label),
              style: style ??
                  OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: style ??
                  OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
              child: Text(label),
            ),
    );
  }
}

class SectionDivider extends StatelessWidget {
  const SectionDivider({
    Key? key,
    this.text = "OR",
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: context.responsiveWidth(),
      child: Row(
        children: [
          Expanded(child: Divider(color: theme.colorScheme.outline)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(text, style: theme.textTheme.bodySmall),
          ),
          Expanded(child: Divider(color: theme.colorScheme.outline)),
        ],
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/logo.png', height: 80, fit: BoxFit.cover),
        SizedBox(height: 20),
        Text(title, style: theme.textTheme.displayMedium),
        Text(subtitle, style: theme.textTheme.titleMedium),
      ],
    );
  }
}
