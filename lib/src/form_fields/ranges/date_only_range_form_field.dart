import 'package:flutter/material.dart';
import '../../../../foo_form_field.dart';

class DateOnlyRangeFormField extends StatelessWidget {
  
  const DateOnlyRangeFormField({
    super.key,
    required this.controller,
    this.dateFormatter,
    this.rangeValidator,
    this.properties,
    this.minDate,
    this.maxDate,
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

  final DateOnlyRangeFieldController controller;
  final FooFormFieldStateProvider<Range<DateOnly>>? stateProvider;
  final String? Function(DateOnly? date)? dateFormatter;
  final RangeValidator? rangeValidator;
  final FooFormFieldProperties<Range<DateOnly>>? properties;

  final DateOnly? minDate;
  final DateOnly? maxDate;

  final DecorationBuilder<DateOnly>? minFieldDecorationBuilder;
  final DecorationBuilder<DateOnly>? maxFieldDecorationBuilder;

  final void Function(BuildContext context)? onTapMinField;
  final void Function(BuildContext context)? onTapMaxField;

  final Widget Function(BuildContext context)? minFieldBuilder;
  final Widget Function(BuildContext context)? maxFieldBuilder;
  final RangeFormFieldBuilder<DateOnly>? builder;
  
  final FooFormFieldStateProvider<DateOnly>? minFieldStateProvider;
  final FooFormFieldStateProvider<DateOnly>? maxFieldStateProvider;


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
    return DateOnlyFormField(
      controller: controller.minController,
      dateFormatter: dateFormatter,
      firstDate: minDate,
      lastDate: controller.maxController.value?? maxDate,
      decorationBuilder: minFieldDecorationBuilder,
      onTap: onTapMinField,
      stateProvider: minFieldStateProvider,
    );
  }

  Widget _maxFieldBuilder( BuildContext context) {
    if(maxFieldBuilder != null) {
      return maxFieldBuilder!(context);
    }
    return DateOnlyFormField(
      controller: controller.maxController,
      dateFormatter: dateFormatter,
      firstDate: controller.minController.value?? minDate,
      lastDate: maxDate,
      decorationBuilder: maxFieldDecorationBuilder,
      onTap: onTapMaxField,
      stateProvider: maxFieldStateProvider,
    );
  }
}

