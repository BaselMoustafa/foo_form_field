import '../../foo_form_field.dart';

class DateTimeFieldController extends ValueFieldController<DateTime> {
  
  DateTimeFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    bool Function(DateTime x, DateTime y)? areEqual,
  }):super(
    areEqual: areEqual ?? ( DateTime x, DateTime y){
      return x.year == y.year 
        && x.month == y.month 
        && x.day == y.day
        && x.hour==y.hour
        && x.minute==y.minute;
    },
  );
}

class DateTimeRangeFieldController extends RangeFieldController<DateTime,DateTimeFieldController> {
  DateTimeRangeFieldController({
    required super.minController,
    required super.maxController,
    super.enabled,
    super.forcedErrorText,
    bool Function(DateTime x, DateTime y)? areEqual,
  }):super(
    areEqualValues: areEqual ?? ( DateTime x, DateTime y){
      return x.year == y.year 
        && x.month == y.month 
        && x.day == y.day
        && x.hour==y.hour
        && x.minute==y.minute;
    },
  );
}