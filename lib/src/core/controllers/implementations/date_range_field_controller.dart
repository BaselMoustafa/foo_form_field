part of '../exporter.dart';

/// Controller for single date fields with customizable equality.
class DateFieldController extends ValueFieldController<DateTime> {
  DateFieldController({
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
class DateRangeFieldController extends RangeFieldController<DateTime> {
  DateRangeFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }) : super(
    areEqualValues: (DateTime x, DateTime y){
      return x.year == y.year && x.month == y.month && x.day == y.day;
    },
  );
}
