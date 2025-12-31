import 'package:flutter/material.dart';

import '../../foo_form_field.dart';

class TimeOfDayRangeFormField extends StatelessWidget {
  const TimeOfDayRangeFormField({
    super.key,
    required this.controller,
    this.timeFormatter,
    this.rangeValidator,
    this.properties,
    this.minFieldDecoration,
    this.maxFieldDecoration,
    this.onTapMinField,
    this.onTapMaxField,
    this.minFieldBuilder,
    this.maxFieldBuilder,
    this.layoutBuilder,
  });

  final TimeOfDayRangeFieldController controller;
  final String? Function(TimeOfDay? time)? timeFormatter;
  final RangeValidator? rangeValidator;
  final FooFormFieldProperties<Range<TimeOfDay>>? properties;

  final InputDecoration? minFieldDecoration;
  final InputDecoration? maxFieldDecoration;

  final void Function(BuildContext context)? onTapMinField;
  final void Function(BuildContext context)? onTapMaxField;

  final Widget Function(BuildContext context, TimeOfDay? value)? minFieldBuilder;
  final Widget Function(BuildContext context, TimeOfDay? value)? maxFieldBuilder;
  final Widget Function(BuildContext context, Widget minField, Widget maxField)? layoutBuilder;


  @override
  Widget build(BuildContext context) {
    return RangeFormField(
      controller: controller, 
      minFieldBuilder: _minFieldBuilder,
      maxFieldBuilder: _maxFieldBuilder, 
      rangeValidator: rangeValidator,
      properties: properties,
      layoutBuilder: layoutBuilder,
    );
  }

  Widget _minFieldBuilder( BuildContext context, TimeOfDay? value) {
    if(minFieldBuilder != null) {
      return minFieldBuilder!(context, value);
    }
    return TimeOfDayFormField(
      controller: controller.minController,
      timeFormatter: timeFormatter,
      decoration: minFieldDecoration,
      onTap: onTapMinField,
    );
  }

  Widget _maxFieldBuilder( BuildContext context, TimeOfDay? value) {
    if(maxFieldBuilder != null) {
      return maxFieldBuilder!(context, value);
    }
    return TimeOfDayFormField(
      controller: controller.maxController,
      timeFormatter: timeFormatter,
      decoration: maxFieldDecoration,
      onTap: onTapMaxField,
    );
  }
}

