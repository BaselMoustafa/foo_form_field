part of '../exporter.dart';

class DateRangeFormField extends RangeFormField<DateTime,DateRangeBoundryFieldController> {

  DateRangeFormField({
    super.key,
    required DateRangeFieldController super.controller,
    Widget Function(BuildContext context,DateRangeBoundryFieldController minValueController,DateTime? value)? minFieldBuilder,
    Widget Function(BuildContext context,DateRangeBoundryFieldController maxValueController,DateTime? value)? maxFieldBuilder,
    RangeValidator<DateTime>? rangeValidator,
    super.layoutBuilder,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    super.restorationId,
    super.onChanged,
  }):super(
    minFieldBuilder: minFieldBuilder?? (context,minValueController,value) => DateFormField(
      controller: minValueController,
      decoration: InputDecoration(
        hintText: "From",
      ),
    ),
    maxFieldBuilder: maxFieldBuilder?? (context,maxValueController,value) => DateFormField(
      controller: maxValueController,
      decoration: InputDecoration(
        hintText: "To",
      ),
    ),
    rangeValidator: rangeValidator?? RangeValidator<DateTime>(
      firstIsBiggerThanSecond: (DateTime first, DateTime second) => first.year>second.year||first.month>second.month||first.day>second.day,
    ),
  );
}