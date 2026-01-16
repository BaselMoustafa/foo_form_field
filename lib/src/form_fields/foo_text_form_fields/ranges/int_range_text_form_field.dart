import 'package:flutter/material.dart';
import '../../../../foo_form_field.dart';

class IntRangeTextFormField extends StatelessWidget {
  
  const IntRangeTextFormField({
    super.key,
    required this.controller,
    this.rangeValidator,
    this.properties,
    this.minFieldProperties,
    this.maxFieldProperties,
    this.minFieldFormatter,
    this.maxFieldFormatter,
    this.builder,
    this.stateProvider,
  });

  final IntRangeTextEditingController controller;
  final TextFormFieldProperties<int>? minFieldProperties;
  final TextFormFieldProperties<int>? maxFieldProperties;
  final IntTextFormatter? minFieldFormatter;
  final IntTextFormatter? maxFieldFormatter;
  final FooFormFieldProperties<Range<int>>? properties;
  final RangeValidator? rangeValidator;
  final RangeFormFieldBuilder<int>? builder;
  final FooFormFieldStateProvider<Range<int>>? stateProvider;

  @override
  Widget build(BuildContext context) {
    return RangeFormField<int, IntTextEditingController>(
      stateProvider: stateProvider,
      controller: controller,
      builder: builder,
      properties: properties,
      rangeValidator: rangeValidator,
      minFieldBuilder: _minFieldBuilder,
      maxFieldBuilder: _maxFieldBuilder,
    );
  }

  Widget _minFieldBuilder(BuildContext context) {
    return IntTextFormField(
      controller: controller.minController,
      properties: minFieldProperties,
      formatter: minFieldFormatter,
    );
  }

  Widget _maxFieldBuilder(BuildContext context) {
    return IntTextFormField(
      controller: controller.maxController,
      properties: maxFieldProperties,
      formatter: maxFieldFormatter,
    );
  }
}
