import 'package:flutter/material.dart';
import 'error_text_widget.dart';

class FieldWithErrorTextWidget extends StatelessWidget {
  const FieldWithErrorTextWidget({
    super.key,
    required this.fieldWidget,
    required this.errorText,
    this.errorTextStyle,
  });

  final Widget fieldWidget;
  final String? errorText;
  final TextStyle? errorTextStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        fieldWidget,
        ErrorTextWidget(errorText: errorText, style: errorTextStyle),
      ],
    );
  }
}
