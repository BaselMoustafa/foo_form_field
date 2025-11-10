import 'package:foo_form_field/src/form_fields/base/foo_form_field.dart';

import '../../core/controllers/base/convertable_value_field_controller.dart';

class ConvertableValueFormField<O,I> extends FooFormField<O,I> {
  const ConvertableValueFormField({
    super.key,
    required ConvertableValueFieldController<O,I> controller,
    required super.builder,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    super.errorBuilder,
    super.restorationId,
    super.onChanged,
  }):super(
    controller: controller,
  );
}