import 'package:flutter/material.dart';
import '../../../foo_form_field.dart';
class NumRangeTextFormField extends StatelessWidget {
  
  const NumRangeTextFormField({
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

  final NumRangeTextEditingController controller;
  final TextFormFieldProperties<num>? minFieldProperties;
  final TextFormFieldProperties<num>? maxFieldProperties;
  final NumTextFormatter? minFieldFormatter;
  final NumTextFormatter? maxFieldFormatter;
  final FooFormFieldProperties<Range<num>>? properties;
  final RangeValidator? rangeValidator;
  final RangeFormFieldBuilder<num>? builder;
  final FooFormFieldStateProvider<Range<num>>? stateProvider;
  @override
  Widget build(BuildContext context) {
    return RangeFormField<num, NumTextEditingController>(
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
    return NumTextFormField(
      controller: controller.minController,
      properties: minFieldProperties,
      formatter: minFieldFormatter,
    );
  }

  Widget _maxFieldBuilder(BuildContext context) {
    return NumTextFormField(
      controller: controller.maxController,
      properties: maxFieldProperties,
      formatter: maxFieldFormatter,
    );
  }
}
