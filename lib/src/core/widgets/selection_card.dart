import 'package:flutter/material.dart';
import 'package:foo_form_field/src/core/style/package_colors.dart';

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
  });

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
      style: defaultTextStyle?? TextStyle(
        color: isSelected ? Colors.white : PackageColors.primary(context),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: height,
          width: width,
          padding: padding?? EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: borderRadius?? BorderRadius.circular(10),
            color: color?? (isSelected ? PackageColors.primary(context) : PackageColors.transparent),
            border: border?? Border.all(
              color: PackageColors.primary(context),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}