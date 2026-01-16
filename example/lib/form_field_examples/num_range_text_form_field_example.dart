import 'dart:developer';

import '../widgets/controller_test_buttons.dart';
import '../widgets/example_screen.dart';
import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class NumRangeTextFormFieldExampleScreen extends StatefulWidget {
  const NumRangeTextFormFieldExampleScreen({super.key});

  @override
  State<NumRangeTextFormFieldExampleScreen> createState() => _NumRangeTextFormFieldExampleScreenState();
}

class _NumRangeTextFormFieldExampleScreenState extends State<NumRangeTextFormFieldExampleScreen> {

  final _controller = NumRangeTextEditingController(
    initialMin: 50.5,
    initialMax: 100.75,
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
      title: "Num String Range Form Field",
      fieldBuilder: ()=>NumRangeTextFormField(
          controller: _controller,
          rangeValidator: RangeValidator(
            equalMinAndMaxMessage: "متساويين يا مدير"
          ),
          minFieldFormatter: NumTextFormatter(
            allowNegative: true,
            maxValue: 18.5
          ),
          maxFieldFormatter: NumTextFormatter(
            allowNegative: true,
            maxValue: 60.75
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
          firstDummyValue: 0.5,
          secondDummyValue: 100.25,
          valueToString: (value) => "$value",
        ),

        ControllerTestButtons(
          title: "Max Controller Test Buttons",
          controller: _controller.maxController,
          firstDummyValue: 100.5,
          secondDummyValue: 200.75,
          valueToString: (value) => "$value",
        ),
      ],
    );
  }
}

