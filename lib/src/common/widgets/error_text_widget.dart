import 'package:flutter/material.dart';
import '../package_colors.dart';

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget({super.key, required this.errorText, this.style});

  final String? errorText;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (Widget child, Animation<double> animation) =>
          SizeTransition(
            sizeFactor: animation,
            axis: Axis.vertical,
            child: FadeTransition(opacity: animation, child: child),
          ),
      duration: Duration(milliseconds: 300),
      child: errorText != null
          ? Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                errorText!,
                key: ValueKey(errorText),
                style:
                    style ??
                    Theme.of(context).inputDecorationTheme.errorStyle ??
                    TextStyle(
                      color: PackageColors.error(context),
                      fontSize: 12,
                    ),
              ),
            )
          : SizedBox.shrink(key: ValueKey(errorText)),
    );
  }
}
