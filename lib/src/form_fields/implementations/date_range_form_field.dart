part of '../exporter.dart';

/// Preconfigured form field for selecting a date range using `DateFormField` builders.
class DateRangeFormField extends RangeFormField<DateTime> {
  DateRangeFormField({
    super.key,
    required DateRangeFieldController super.controller,
    Widget Function(
      BuildContext context,
      DateTime? value,
    )? minFieldBuilder,
    Widget Function(
      BuildContext context,
      DateTime? value,
    )? maxFieldBuilder,
    RangeValidator<DateTime>? rangeValidator,
    super.layoutBuilder,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    super.restorationId,
    super.onChanged,
  }) : super(
         minFieldBuilder:
             minFieldBuilder ??
             (context, value) => DateFormField(
               controller: controller.minValueController,
               decoration: InputDecoration(hintText: "From"),
             ),
         maxFieldBuilder:
             maxFieldBuilder ??
             (context, value) => DateFormField(
               controller: controller.maxValueController,
               decoration: InputDecoration(hintText: "To"),
             ),
         rangeValidator:
             rangeValidator ??
             RangeValidator<DateTime>(
               firstIsBiggerThanSecond: (DateTime first, DateTime second) =>
                   first.year > second.year ||
                   first.month > second.month ||
                   first.day > second.day,
             ),
       );
}
