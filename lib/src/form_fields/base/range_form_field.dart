import 'convertable_range_form_field.dart';
import '../../controllers/base/value_field_controller.dart';
import '../../controllers/base/range_field_controller.dart';

class RangeFormField<
  Value extends Comparable, 
  BoundryController extends ValueFieldController<Value>
> extends ConvertableRangeFormField<Value, Value, BoundryController, RangeFieldController<Value, BoundryController>> {
  const RangeFormField({
    super.key,
    required super.controller,
    required super.minFieldBuilder,
    required super.maxFieldBuilder,
    required super.rangeValidator,
    super.builder,
    super.properties,
  });
}
