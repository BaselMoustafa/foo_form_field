import 'dart:developer';

import '../models/section.dart';
import '../models/text_button_input.dart';
import 'section_widget.dart';
import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class ControllerTestButtons<O,I> extends StatelessWidget {
  const ControllerTestButtons({
    super.key, 
    required this.title,
    required this.controller, 
    required this.valueToString,
    required this.firstDummyValue,
    required this.secondDummyValue,
  });

  final String title;
  final O firstDummyValue;
  final O secondDummyValue;
  final String Function(O value) valueToString;
  final FooFieldController<O,I> controller;

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      section: Section(
        title: title,
        buttonsInputs: [
          TextButtonInput(
            title: "Get Value",
            onPressed: () {
              log("value = ${controller.value}");
            },
          ),
          TextButtonInput(
            title: "Clear",
            onPressed: () {
              controller.clear();
            },
          ),
          // TextButtonInput(
          //   title: "Validate",
          //   onPressed: () {
          //     controller.validate();
          //   },
          // ),
          // TextButtonInput(
          //   title: "Get Is Valid",
          //   onPressed: () {
          //     log("Get isValid = ${controller.isValid}");
          //   },
          // ),
          // TextButtonInput(
          //   title: "Set Forced Error Text",
          //   onPressed: () {
          //     controller.forcedErrorText = 'forced error';
          //   },
          // ),
          // TextButtonInput(
          //   title: "Clear Forced Error Text",
          //   onPressed: () {
          //     controller.forcedErrorText = null;
          //   },
          // ),
          // TextButtonInput(
          //   title: "Save",
          //   onPressed: () {
          //     controller.save();
          //   },
          // ),    
          TextButtonInput(
            title: "Set ${valueToString(firstDummyValue)}",
            onPressed: () {
              controller.value = firstDummyValue;
            },
          ),
          TextButtonInput(
            title: "Set ${valueToString(secondDummyValue)}",
            onPressed: () {
              controller.value = secondDummyValue;
            },
          ),
        ],
      ),
    );
  }
}