import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/form_fields/base/convertable_value_form_field.dart';

class ValueFormField<T> extends ConvertableValueFormField<T,T> {

  const ValueFormField({
    super.key, 
    required ValueFieldController<T> controller, 
    required super.builder,
  }):super(
    controller: controller,
  );
}