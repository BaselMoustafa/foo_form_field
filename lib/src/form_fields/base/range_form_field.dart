import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/core/controllers/base/range_boundry_field_controller.dart';
import 'package:foo_form_field/src/form_fields/base/convertable_range_form_field.dart';

class RangeFormField<T> extends ConvertableRangeFormField<T,T,RangeBoundryFieldController<T>> {
  
  const RangeFormField({
    super.key,
    required RangeFieldController<T> controller,
    required super.minFieldBuilder,
    required super.maxFieldBuilder,
    required super.rangeValidator,
    super.layoutBuilder,
    super.onSaved,
    super.validator,
  }):super(
    controller: controller,
  );
}