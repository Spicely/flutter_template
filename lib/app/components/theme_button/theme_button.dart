import 'package:flutter/material.dart';

import '../../data/theme/theme_custom.dart';

class ThemeButton extends StatelessWidget {
  final double? width;

  final double? height;

  final Widget? child;

  final VoidCallback? onPressed;

  final Gradient? gradient;

  const ThemeButton({
    super.key,
    this.child,
    required this.onPressed,
    this.width,
    this.height,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90.0)),
          padding: const EdgeInsets.all(0.0),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: onPressed == null ? null : gradient ?? LinearGradient(colors: context.eTheme.gradientColors),
            borderRadius: const BorderRadius.all(Radius.circular(90.0)),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
