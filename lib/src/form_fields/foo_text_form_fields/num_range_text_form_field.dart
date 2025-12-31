
import 'package:flutter/material.dart';

import '../../common/ranges/range_validators.dart';
import '../../controllers/foo_text_editing_controllers/num_text_editing_controller.dart';
import '../../common/formatters/num_text_formatter.dart';
import '../../common/models/foo_form_field_properties.dart';
import '../../common/ranges/ranges.dart';
import '../../common/models/text_from_field_properties.dart';
import '../base/convertable_range_form_field.dart';
import 'num_text_form_field.dart';

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
    this.layoutBuilder,
  });

  final NumRangeTextEditingController controller;
  final TextFormFieldProperties<num>? minFieldProperties;
  final TextFormFieldProperties<num>? maxFieldProperties;
  final NumTextFormatter? minFieldFormatter;
  final NumTextFormatter? maxFieldFormatter;
  final FooFormFieldProperties<Range<num>>? properties;
  final NumRangeValidator? rangeValidator;
  final Widget Function(BuildContext context, Widget minField, Widget maxField)? layoutBuilder;

  @override
  Widget build(BuildContext context) {
    return ConvertableRangeFormField(
      controller: controller,
      layoutBuilder: layoutBuilder,
      properties: properties,
      rangeValidator: rangeValidator ?? NumRangeValidator(),
      minFieldBuilder: _minFieldBuilder,
      maxFieldBuilder: _maxFieldBuilder,
    );
  }

  Widget _minFieldBuilder(BuildContext context, String? value) {
    return NumTextFormField(
      controller: controller.minController,
      properties: minFieldProperties,
      formatter: minFieldFormatter,
    );
  }

  Widget _maxFieldBuilder(BuildContext context, String? value) {
    return NumTextFormField(
      controller: controller.maxController,
      properties: maxFieldProperties,
      formatter: maxFieldFormatter,
    );
  }
}
