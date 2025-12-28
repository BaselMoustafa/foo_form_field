
import '../../../core/models/mapper.dart';
import '../../../core/models/range.dart';
import '../convertable_range_form_field/convertable_range_field_controller.dart';
import '../value_form_field/value_field_controller.dart';

class RangeFieldController<
  Value,
  BoundryController extends ValueFieldController<Value>
> extends ConvertableRangeFieldController<Value, Value, BoundryController> {

  RangeFieldController({
    required super.minController,
    required super.maxController,
    required super.areEqualValues,
    super.enabled,
    super.forcedErrorText,
  }) : super(
    mapper: Mapper.sameValueMapper<Range<Value>>(),
  );
}
