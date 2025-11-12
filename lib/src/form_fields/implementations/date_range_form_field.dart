import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class DateRangeFormField extends RangeFormField<DateTime,DateRangeBoundryFieldController> {

  DateRangeFormField({
    super.key,
    required DateRangeFieldController super.controller,
    Widget Function(BuildContext context,DateRangeBoundryFieldController minValueController)? minFieldBuilder,
    Widget Function(BuildContext context,DateRangeBoundryFieldController maxValueController)? maxFieldBuilder,
    RangeValidator<DateTime>? rangeValidator,
    super.layoutBuilder,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    super.errorBuilder,
    super.restorationId,
    super.onChanged,
  }):super(
    minFieldBuilder: minFieldBuilder?? (context,minValueController) => DateFormField(controller: minValueController),
    maxFieldBuilder: maxFieldBuilder?? (context,maxValueController) => DateFormField(controller: maxValueController),
    rangeValidator: rangeValidator?? RangeValidator<DateTime>(
      firstIsBiggerThanSecond: (DateTime first, DateTime second) => first.year>second.year||first.month>second.month||first.day>second.day,
    ),
  );
}