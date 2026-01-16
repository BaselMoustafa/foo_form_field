import 'package:flutter/material.dart';

import '../../../../foo_form_field.dart';

class TimeOfDayRangeFormField extends StatelessWidget {
  const TimeOfDayRangeFormField({
    super.key,
    required this.controller,
    this.timeFormatter,
    this.rangeValidator,
    this.properties,
    this.minFieldDecorationBuilder,
    this.maxFieldDecorationBuilder,
    this.onTapMinField,
    this.onTapMaxField,
    this.minFieldBuilder,
    this.maxFieldBuilder,
    this.builder,
    this.minFieldStateProvider,
    this.maxFieldStateProvider,
    this.stateProvider,
  });

  final TimeOfDayRangeFieldController controller;
  final FooFormFieldStateProvider<Range<TimeOfDay>>? stateProvider;
  final String? Function(TimeOfDay? time)? timeFormatter;
  final RangeValidator? rangeValidator;
  final FooFormFieldProperties<Range<TimeOfDay>>? properties;

  final DecorationBuilder<TimeOfDay>? minFieldDecorationBuilder;
  final DecorationBuilder<TimeOfDay>? maxFieldDecorationBuilder;

  final void Function(BuildContext context)? onTapMinField;
  final void Function(BuildContext context)? onTapMaxField;

  final Widget Function(BuildContext context)? minFieldBuilder;
  final Widget Function(BuildContext context)? maxFieldBuilder;
  final RangeFormFieldBuilder<TimeOfDay>? builder;
  
  final FooFormFieldStateProvider<TimeOfDay>? minFieldStateProvider;
  final FooFormFieldStateProvider<TimeOfDay>? maxFieldStateProvider;


  @override
  Widget build(BuildContext context) {
    return RangeFormField(
      controller: controller, 
      stateProvider: stateProvider,
      minFieldBuilder: _minFieldBuilder,
      maxFieldBuilder: _maxFieldBuilder, 
      rangeValidator: rangeValidator,
      properties: properties,
      builder: builder,
    );
  }

  Widget _minFieldBuilder( BuildContext context) {
    if(minFieldBuilder != null) {
      return minFieldBuilder!(context);
    }
    return TimeOfDayFormField(
      controller: controller.minController,
      timeFormatter: timeFormatter,
      decorationBuilder: minFieldDecorationBuilder,
      onTap: onTapMinField,
      stateProvider: minFieldStateProvider,
    );
  }

  Widget _maxFieldBuilder( BuildContext context) {
    if(maxFieldBuilder != null) {
      return maxFieldBuilder!(context);
    }
    return TimeOfDayFormField(
      controller: controller.maxController,
      timeFormatter: timeFormatter,
      decorationBuilder: maxFieldDecorationBuilder  ,
      onTap: onTapMaxField,
      stateProvider: maxFieldStateProvider,
    );
  }
}

