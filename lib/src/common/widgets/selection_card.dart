import 'package:flutter/material.dart';
import '../package_colors.dart';

class SelectionCard extends StatelessWidget {
  const SelectionCard({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.child,
    this.padding,
    this.borderRadius,
    this.border,
    this.color,
    this.height,
    this.width,
    this.defaultTextStyle,
    this.enabled = true,
  });

  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Border? border;
  final Color? color;
  final double? height;
  final double? width;
  final TextStyle? defaultTextStyle;
  final VoidCallback onTap;
  final bool isSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style:
          defaultTextStyle ??
          TextStyle(
            color: isSelected ? Colors.white : _effectiveColor(context),
          ),
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          alignment: Alignment.center,
          height: height,
          width: width,
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            color:
                color ??
                (isSelected
                    ? _effectiveColor(context)
                    : PackageColors.transparent),
            border: border ?? Border.all(color: _effectiveColor(context)),
          ),
          child: child,
        ),
      ),
    );
  }

  Color _effectiveColor(BuildContext context) => enabled
      ? (color ?? PackageColors.primary(context))
      : PackageColors.disabled(context);
}
