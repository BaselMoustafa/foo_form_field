
import '../foo_form_field/foo_form_field.dart';

class ValueFormField<T> extends FooFormField<T, T> {
  const ValueFormField({
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
