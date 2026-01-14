import '../../foo_form_field.dart';
import '../common/extentions/comparable_extension.dart';

class DateTimeFieldController extends ValueFieldController<DateTime> {
  
  DateTimeFieldController({
    super.initialValue,
  }):super(
    areEqual: (DateTime x, DateTime y) =>x.isEqualTo(y),
  );
}

class DateTimeRangeFieldController extends RangeFieldController<DateTime,DateTimeFieldController> {
  DateTimeRangeFieldController({
    required super.minController,
    required super.maxController,
  });
}