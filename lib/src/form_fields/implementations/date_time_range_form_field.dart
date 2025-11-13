part of '../exporter.dart';

/// Preconfigured form field for selecting a date range using `DateFormField` builders.
class DateTimeRangeFormField extends RangeFormField<DateTime> {
  DateTimeRangeFormField({
    super.key,
    required DateTimeRangeFieldController super.controller,
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
             (context, value) => DateTimeFormField(
               controller: controller.minValueController,
               decoration: InputDecoration(hintText: "From"),
             ),
         maxFieldBuilder:
             maxFieldBuilder ??
             (context, value) => DateTimeFormField(
               controller: controller.maxValueController,
               decoration: InputDecoration(hintText: "To"),
             ),
         rangeValidator:
             rangeValidator ??DateTimeRangeValidator(),
       );
}
