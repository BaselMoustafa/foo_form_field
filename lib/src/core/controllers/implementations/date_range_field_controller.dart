part of '../exporter.dart';

class DateFieldController extends ValueFieldController<DateTime> {
  DateFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    bool Function(DateTime x, DateTime y)? areEqual,
  }):super(
    areEqual: areEqual?? (DateTime x, DateTime y) => x.year == y.year && x.month == y.month && x.day == y.day,
  );
}

class DateRangeBoundryFieldController extends RangeBoundryFieldController<DateTime> {
  DateRangeBoundryFieldController({
    required super.isMin,
    required super.rangeFieldController,
  });
}

class DateRangeFieldController extends RangeFieldController<DateTime,DateRangeBoundryFieldController> {
  DateRangeFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }):super(
    areEqualValues: (DateTime x, DateTime y) => x.year == y.year && x.month == y.month && x.day == y.day,
    minBoundryControllerBuilder: (rangeFieldController) => DateRangeBoundryFieldController(
      isMin: true,
      rangeFieldController: rangeFieldController,
    ),
    maxBoundryControllerBuilder: (rangeFieldController) => DateRangeBoundryFieldController(
      isMin: false,
      rangeFieldController: rangeFieldController,
    ),
  );
}