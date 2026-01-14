
import '../../../foo_form_field.dart';

class RangeFieldController<
  Value extends Comparable,
  BoundryController extends ValueFieldController<Value>
> extends ConvertableRangeFieldController<Value, Value, BoundryController> {

  RangeFieldController({
    required super.minController,
    required super.maxController,
  }) : super(
    mapper: Mapper.sameValueMapper<Range<Value>>(),
  );
}
