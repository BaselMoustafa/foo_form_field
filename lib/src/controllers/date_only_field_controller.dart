import '../../foo_form_field.dart';
import '../common/extentions/comparable_extension.dart';

class DateOnlyFieldController extends ValueFieldController<DateOnly> {
  
  DateOnlyFieldController({
    super.initialValue,
  }):super(
    areEqual: (DateOnly x, DateOnly y) => x.isEqualTo(y),
  );
}

class DateOnlyRangeFieldController extends RangeFieldController<DateOnly,DateOnlyFieldController> {
  DateOnlyRangeFieldController({
    required super.minController,
    required super.maxController,
  });
}

