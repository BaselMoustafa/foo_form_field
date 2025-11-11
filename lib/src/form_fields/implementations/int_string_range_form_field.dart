
import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';


class IntStringRangeFormField extends StatelessWidget {
  const IntStringRangeFormField({
    super.key,
    required this.controller,
    this.minFieldBuilder,
    this.maxFieldBuilder,
    this.rangeValidator,
    this.layoutBuilder,
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.errorBuilder,
    this.restorationId,
    this.onChanged,
  });

  final RangeValidator<int>? rangeValidator;
  final IntStringRangeFieldController controller;
  final Widget Function(BuildContext context,IntStringRangeBoundryFieldController minValueController)? minFieldBuilder;
  final Widget Function(BuildContext context,IntStringRangeBoundryFieldController maxValueController)? maxFieldBuilder;
  final Widget Function(BuildContext context,Widget minField,Widget maxField)? layoutBuilder;
  final void Function(Range<int?>? value)? onSaved;
  final String? Function(Range<int?>? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final FormFieldErrorBuilder? errorBuilder;
  final String? restorationId;
  final void Function(Range<int?>? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ConvertableRangeFormField(
      controller: controller,
      layoutBuilder: layoutBuilder,
      onSaved: onSaved,
      validator: validator,
      autovalidateMode: autovalidateMode,
      errorBuilder: errorBuilder,
      restorationId: restorationId,
      onChanged: onChanged,
      rangeValidator: rangeValidator?? RangeValidator<int>(
        firstIsBiggerThanSecond: (int first, int second) => first > second,
      ),
      minFieldBuilder: _minFieldBuilder,
      maxFieldBuilder: _maxFieldBuilder,
    );
  }

  Widget _minFieldBuilder(BuildContext context,IntStringRangeBoundryFieldController minValueController){
    if (minFieldBuilder!=null) {
      return minFieldBuilder!(context,minValueController);
    }
    return IntStringFormField(controller: minValueController);
  }

  Widget _maxFieldBuilder(BuildContext context,IntStringRangeBoundryFieldController maxValueController){
    if (maxFieldBuilder!=null) {
      return maxFieldBuilder!(context,maxValueController);
    }
    return IntStringFormField(controller: maxValueController);
  }
}