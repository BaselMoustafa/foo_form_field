import 'convertable_range_form_field.dart';
import '../../controllers/base/value_field_controller.dart';
import '../../controllers/base/range_field_controller.dart';

class RangeFormField<T, BoundryController extends ValueFieldController<T>> extends ConvertableRangeFormField<T, T, BoundryController> {
  const RangeFormField({
    super.key,
    required RangeFieldController<T, BoundryController> super.controller,
    required super.minFieldBuilder,
    required super.maxFieldBuilder,
    required super.rangeValidator,
    super.layoutBuilder,
    super.properties,
  });
}
