
import '../../../foo_form_field.dart';

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
