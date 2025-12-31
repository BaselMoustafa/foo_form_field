import '../../foo_form_field.dart';

class DateOnlyFieldController extends ValueFieldController<DateOnly> {
  
  DateOnlyFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }):super(
    areEqual: (DateOnly x, DateOnly y) => x == y,
  );
}

class DateOnlyRangeFieldController extends RangeFieldController<DateOnly,DateOnlyFieldController> {
  DateOnlyRangeFieldController({
    required super.minController,
    required super.maxController,
    super.enabled,
    super.forcedErrorText,
  }):super(
    areEqualValues: (DateOnly x, DateOnly y) => x == y,
  );
}

