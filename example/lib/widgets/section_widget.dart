import '../models/section.dart';
import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({super.key, required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        Wrap(
          spacing: 20,
          children: section.buttonsInputs.map(
            (buttonInput) => TextButton(
              onPressed: buttonInput.onPressed,
              child: Text(buttonInput.title),
            ),
          ).toList(),
        ),
      ],
    );
  }
}