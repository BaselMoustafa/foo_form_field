import 'dart:developer';

import '../widgets/controller_test_buttons.dart';
import '../widgets/example_screen.dart';
import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class IntRangeTextFormFieldExampleScreen extends StatefulWidget {
  const IntRangeTextFormFieldExampleScreen({super.key});

  @override
  State<IntRangeTextFormFieldExampleScreen> createState() => _IntRangeTextFormFieldExampleScreenState();
}

class _IntRangeTextFormFieldExampleScreenState extends State<IntRangeTextFormFieldExampleScreen> {

  final _controller = IntRangeTextEditingController(
    minController: IntTextEditingController(
      initialValue: 50,
      enabled: false,
    ),
    maxController: IntTextEditingController(
      initialValue: 100,
    ),
  );

  @override
  void initState() {
    super.initState();
    _valueDebguer(controller: _controller);
    _valueDebguer(controller: _controller.minController);
    _valueDebguer(controller: _controller.maxController);
  }

  void _valueDebguer({
    required FooFieldController controller,
  }) {
    controller.addListener(
      () {
        log("${controller.runtimeType} Value: ${controller.value}");
        
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return ExampleScreen(
      title: "Int String Range Form Field",
      fieldBuilder: ()=>IntRangeTextFormField(
          controller: _controller,
          minFieldFormatter: IntTextFormatter(
            allowNegative: true,
            maxValue: 18
          ),
          maxFieldFormatter: IntTextFormatter(
            allowNegative: true,
            maxValue: 60
          ),
          properties: FooFormFieldProperties(
            onSaved: (value) => log("Range Saved: $value"),
            onChanged: (value) => log("Range Changed To: $value"),
            
            validator: (value) {
              if (value == null ) {
                return 'This field is required';
              }
              return null;
            },
          ),
          minFieldProperties: TextFormFieldProperties(
            validator: (value) {
              if (value == null) {
                return 'Min Required';
              }
              return null;
            },
            onSaved: (value) => log("Min Saved: $value"),
            onChanged: (value) => log("Min Changed: $value"),
            
          ),
          maxFieldProperties: TextFormFieldProperties(
            validator: (value) {
              if (value == null) {
                return 'Max Required';
              }
              return null;
            },
            onSaved: (value) => log("Max Saved: $value"),
            onChanged: (value) => log("Max Changed: $value"),
          ),
        ),
      children: [
        ControllerTestButtons(
          title: "Min Controller Test Buttons",
          controller: _controller.minController,
          firstDummyValue: 0,
          secondDummyValue: 100,
          valueToString: (value) => "$value",
        ),

        ControllerTestButtons(
          title: "Max Controller Test Buttons",
          controller: _controller.maxController,
          firstDummyValue: 100,
          secondDummyValue: 200,
          valueToString: (value) => "$value",
        ),
      ],
    );
  }
}