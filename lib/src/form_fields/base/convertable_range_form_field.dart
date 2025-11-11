import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/core/widgets/field_with_error_text_widget.dart';

class ConvertableRangeFormField<O,I,B extends ConvertableRangeBoundryFieldController<O,I>> extends StatelessWidget {
  const ConvertableRangeFormField({
    super.key,
    required this.controller,
    required this.rangeValidator,
    required this.minFieldBuilder,
    required this.maxFieldBuilder,
    this.layoutBuilder,
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.errorBuilder,
    this.restorationId,
    this.onChanged,
  });

  final ConvertableRangeFieldController<O,I,B> controller;
  final RangeValidator<O> rangeValidator; 
  final Widget Function(BuildContext context,B minValueController) minFieldBuilder;
  final Widget Function(BuildContext context,B maxValueController) maxFieldBuilder;

  final Widget Function(BuildContext context,Widget minField,Widget maxField)? layoutBuilder;

  final void Function(Range<O?>? value)? onSaved;
  final String? Function(Range<O?>? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final FormFieldErrorBuilder? errorBuilder;
  final String? restorationId;
  final void Function(Range<O?>? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return FooFormField<Range<O>,Range<I>>(
      builder: _builder,
      controller: controller, 
      onSaved: onSaved,
      autovalidateMode: autovalidateMode,
      errorBuilder: errorBuilder,
      restorationId: restorationId,
      onChanged: onChanged,
      validator: _validator,
    );
  }

  String? _validator(Range<O>? value){
    if (value == null) {
      return validator?.call(value);
    }

    String? equalityError = rangeValidator.validateEquality(value);
    if (equalityError != null) {
      return equalityError;
    }

    String? minError = rangeValidator.validateMin(value);
    if (minError != null) {
      return minError;
    }

    String? maxError = rangeValidator.validateMax(value);
    if (maxError != null) {
      return maxError;
    }
    return validator?.call(value);
  }

  Widget _builder(BuildContext context){
    final minField = minFieldBuilder(context,controller.minValueController);
    final maxField = maxFieldBuilder(context,controller.maxValueController);

    return FieldWithErrorTextWidget(
      errorText: controller.errorText,
      fieldWidget: layoutBuilder?.call(context,minField,maxField) ?? Row(
        spacing: 10,
        children: [
          Expanded(child: minField),
          Expanded(child: maxField),
        ],
      ),
    );
  }

}