import 'package:foo_form_field/src/form_fields/base/foo_form_field.dart';

class ConvertableValueFormField<O,I> extends FooFormField<O,I> {
  const ConvertableValueFormField({
    super.key,
    required super.controller,
    required super.builder,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    super.errorBuilder,
    super.restorationId,
    super.onChanged,
  });
}