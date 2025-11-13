part of '../exporter.dart';

/// Controller for single date fields with customizable equality.
class DateTimeFieldController extends ValueFieldController<DateTime> {
  DateTimeFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    bool Function(DateTime x, DateTime y)? areEqual,
  }) : super(
    areEqual:areEqual ??(DateTime x, DateTime y){
      return x.year == y.year && x.month == y.month && x.day == y.day;
    },
  );
}

/// Controller for date ranges, wiring min/max bound controllers and equality.
class DateTimeRangeFieldController extends RangeFieldController<DateTime> {
  DateTimeRangeFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    bool Function(DateTime x, DateTime y)? areEqualValues,
  }) : super(
    areEqualValues: areEqualValues ?? (DateTime x, DateTime y) => x.year == y.year && x.month == y.month && x.day == y.day,
  );
}
