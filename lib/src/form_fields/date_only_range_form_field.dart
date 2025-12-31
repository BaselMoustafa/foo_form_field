import 'package:flutter/material.dart';

import '../../foo_form_field.dart';

class DateOnlyRangeFormField extends StatelessWidget {
  const DateOnlyRangeFormField({
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
    this.layoutBuilder,
  });

  final DateOnlyRangeFieldController controller;
  final String? Function(DateOnly? date)? dateFormatter;
  final DateOnlyRangeValidator? rangeValidator;
  final FooFormFieldProperties<Range<DateOnly>>? properties;

  final DateOnly? minDate;
  final DateOnly? maxDate;

  final InputDecoration? minFieldDecoration;
  final InputDecoration? maxFieldDecoration;

  final void Function(BuildContext context)? onTapMinField;
  final void Function(BuildContext context)? onTapMaxField;

  final Widget Function(BuildContext context, DateOnly? value)? minFieldBuilder;
  final Widget Function(BuildContext context, DateOnly? value)? maxFieldBuilder;
  final Widget Function(BuildContext context, Widget minField, Widget maxField)? layoutBuilder;


  @override
  Widget build(BuildContext context) {
    return RangeFormField(
      controller: controller, 
      minFieldBuilder: _minFieldBuilder,
      maxFieldBuilder: _maxFieldBuilder, 
      rangeValidator: rangeValidator ?? DateOnlyRangeValidator(),
      properties: properties,
      layoutBuilder: layoutBuilder,
    );
  }

  Widget _minFieldBuilder( BuildContext context, DateOnly? value) {
    if(minFieldBuilder != null) {
      return minFieldBuilder!(context, value);
    }
    return DateOnlyFormField(
      controller: controller.minController,
      dateFormatter: dateFormatter,
      firstDate: minDate,
      lastDate: controller.maxController.value?? maxDate,
      decoration: minFieldDecoration,
      onTap: onTapMinField,
    );
  }

  Widget _maxFieldBuilder( BuildContext context, DateOnly? value) {
    if(maxFieldBuilder != null) {
      return maxFieldBuilder!(context, value);
    }
    return DateOnlyFormField(
      controller: controller.maxController,
      dateFormatter: dateFormatter,
      firstDate: controller.minController.value?? minDate,
      lastDate: maxDate,
      decoration: maxFieldDecoration,
      onTap: onTapMaxField,
    );
  }
}

