import 'package:foo_form_field/src/core/controllers/base/convertable_value_field_controller.dart';
import 'package:foo_form_field/src/core/mappers/base/same_value_mapper.dart';

class ValueFieldController<T> extends ConvertableValueFieldController<T,T> {

  ValueFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    required super.areEqual, required mapper,
  }): super(
    mapper: SameValueMapper<T>(),
  );
}