import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/core/models/range.dart';
import 'package:foo_form_field/src/core/models/range_validator.dart';
import 'package:foo_form_field/src/form_fields/base/value_form_field.dart';

class RangeFormField<T> extends StatelessWidget {
  const RangeFormField({
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

  final RangeFieldController<T> controller;
  final RangeValidator<T> rangeValidator; 
  final Widget Function(BuildContext context,ValueFieldController<T> minValueController) minFieldBuilder;
  final Widget Function(BuildContext context,ValueFieldController<T> maxValueController) maxFieldBuilder;

  final Widget Function(BuildContext context,Widget minField,Widget maxField)? fieldBuilder;
  final Widget Function(BuildContext context,Widget fieldWidget,String? errorText)? layoutBuilder;

  final void Function(Range<T?>? value)? onSaved;
  final String? Function(Range<T?>? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final FormFieldErrorBuilder? errorBuilder;
  final String? restorationId;
  final void Function(Range<T?>? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueFormField<Range<T>>(
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

  void _onChanged(Range<T>? value){
    controller.maxValueController.forcedErrorText =null;
    controller.minValueController.forcedErrorText =null;
    onChanged?.call(value);
  }

  String? _validator(Range<T?>? value){
    if (value == null) {
      return validator?.call(value);
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

    String? equalityError = rangeValidator.validateEquality(value);
    if (equalityError != null) {
      controller.forcedErrorText = equalityError;
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