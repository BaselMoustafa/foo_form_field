import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/form_fields/base/convertable_value_form_field.dart';

class ConvertableRangeFormField<O,I> extends StatelessWidget {
  const ConvertableRangeFormField({
    super.key,
    required this.controller,
    required this.minFieldBuilder,
    required this.maxFieldBuilder,
    required this.rangeValidator,
    this.layoutBuilder,
    this.fieldBuilder,
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.errorBuilder,
    this.restorationId,
    this.onChanged,
  });

  final ConvertableRangeFieldController<O,I> controller;
  final RangeValidator<O> rangeValidator; 
  final Widget Function(BuildContext context,FooFieldController<O,I> minValueController) minFieldBuilder;
  final Widget Function(BuildContext context,FooFieldController<O,I> maxValueController) maxFieldBuilder;

  final Widget Function(BuildContext context,Widget minField,Widget maxField)? fieldBuilder;
  final Widget Function(BuildContext context,Widget fieldWidget,String? errorText)? layoutBuilder;

  final void Function(Range<O?>? value)? onSaved;
  final String? Function(Range<O?>? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final FormFieldErrorBuilder? errorBuilder;
  final String? restorationId;
  final void Function(Range<O?>? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ConvertableValueFormField<Range<O>,Range<I>>(
      controller: controller, 
      onSaved: onSaved,
      autovalidateMode: autovalidateMode,
      errorBuilder: errorBuilder,
      restorationId: restorationId,
      onChanged: _onChanged,
      layoutBuilder: layoutBuilder,
      validator: _validator,
      fieldBuilder: _fieldBuilder,
    );
  }

  void _onChanged(Range<O>? value){
    throw UnimplementedError("Will be implemented later");
    if (controller.minValueController.forcedErrorText != null) {
      controller.minValueController.forcedErrorText =null;
    }
    if (controller.maxValueController.forcedErrorText != null) {
      controller.maxValueController.forcedErrorText =null;
    }
    if (controller.forcedErrorText != null) {
      controller.forcedErrorText = null;
    }
    onChanged?.call(value);
  }

  String? _validator(Range<O?>? value){
    log("Validator Called with value: $value");
    if (value == null) {
      return validator?.call(value);
    }

    String? equalityError = rangeValidator.validateEquality(value);
    if (equalityError != null) {
      controller.forcedErrorText = equalityError;
      return null;
    }

    String? minError = rangeValidator.validateMin(value);
    if (minError != null) {
      controller.minValueController.forcedErrorText = minError;
      return null;
    }

    String? maxError = rangeValidator.validateMax(value);
    if (maxError != null) {
      controller.maxValueController.forcedErrorText = maxError;
      return null;
    }
    return validator?.call(value);
  }

  Widget _fieldBuilder(BuildContext context){
    final minField = minFieldBuilder(context,controller.minValueController);
    final maxField = maxFieldBuilder(context,controller.maxValueController);

    if (fieldBuilder!=null) {
      return fieldBuilder!(context,minField,maxField);
    }

    return Row(
      spacing: 6,
      children: [
        Expanded(child: minField),
        Expanded(child: maxField),
      ],
    );
  }

}