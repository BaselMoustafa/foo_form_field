import '../convertable_range_form_field/convertable_range_form_field.dart';
import '../value_form_field/value_field_controller.dart';
import 'range_field_controller.dart';

class RangeFormField<T, BoundryController extends ValueFieldController<T>> extends ConvertableRangeFormField<T, T, BoundryController> {
  const RangeFormField({
    super.key,
    required RangeFieldController<T, BoundryController> super.controller,
    required super.minFieldBuilder,
    required super.maxFieldBuilder,
    required super.rangeValidator,
    super.layoutBuilder,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    super.restorationId,
    super.onChanged,
  });
}
