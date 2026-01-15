import 'package:flutter/material.dart';

import '../../foo_form_field.dart';

class DateTimeRangeFormField extends StatelessWidget {
  const DateTimeRangeFormField({
    super.key,
    required this.controller,
    this.dateFormatter,
    this.rangeValidator,
    this.properties,
    this.minDate,
    this.maxDate,
    this.minFieldDecoration,
    this.maxFieldDecoration,
    this.onTapMinField,
    this.onTapMaxField,
    this.minFieldBuilder,
    this.maxFieldBuilder,
    this.builder,
  });

  final DateTimeRangeFieldController controller;
  final String? Function(DateTime? date)? dateFormatter;
  final RangeValidator? rangeValidator;
  final FooFormFieldProperties<Range<DateTime>>? properties;

  final DateTime? minDate;
  final DateTime? maxDate;

  final InputDecoration? minFieldDecoration;
  final InputDecoration? maxFieldDecoration;

  final void Function(BuildContext context)? onTapMinField;
  final void Function(BuildContext context)? onTapMaxField;

  final Widget Function(BuildContext context, DateTime? value)? minFieldBuilder;
  final Widget Function(BuildContext context, DateTime? value)? maxFieldBuilder;

  final RangeFormFieldBuilder<DateTime>? builder;

  @override
  Widget build(BuildContext context) {
    return RangeFormField(
      controller: controller, 
      minFieldBuilder: _minFieldBuilder,
      maxFieldBuilder: _maxFieldBuilder, 
      rangeValidator: rangeValidator,
      properties: properties,
      builder: builder,
    );
  }

  Widget _minFieldBuilder( BuildContext context, DateTime? value) {
    if(minFieldBuilder != null) {
      return minFieldBuilder!(context, value);
    }
    return DateTimeFormField(
      controller: controller.minController,
      dateFormatter: dateFormatter,
      firstDate: minDate,
      lastDate: controller.maxController.value?? maxDate,
      decoration: minFieldDecoration,
      onTap: onTapMinField,
    );
  }

  Widget _maxFieldBuilder( BuildContext context, DateTime? value) {
    if(maxFieldBuilder != null) {
      return maxFieldBuilder!(context, value);
    }
    return DateTimeFormField(
      controller: controller.maxController,
      dateFormatter: dateFormatter,
      firstDate: controller.minController.value?? minDate,
      lastDate: maxDate,
      decoration: maxFieldDecoration,
      onTap: onTapMaxField,
    );
  }
}