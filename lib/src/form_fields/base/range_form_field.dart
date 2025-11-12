import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/core/controllers/base/range_boundry_field_controller.dart';

class RangeFormField<T,B extends RangeBoundryFieldController<T>> extends ConvertableRangeFormField<T,T,B> {
  
  const RangeFormField({
    super.key,
    required RangeFieldController<T,B> super.controller,
    required super.minFieldBuilder,
    required super.maxFieldBuilder,
    required super.rangeValidator,
    super.layoutBuilder,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    super.errorBuilder,
    super.restorationId,
    super.onChanged,
  });
}