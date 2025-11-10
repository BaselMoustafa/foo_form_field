import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/core/mappers/base/same_value_mapper.dart';

class ValueFieldController<T> extends FooFieldController<T,T> {

  ValueFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    required super.areEqual,
  }): super(
    mapper: SameValueMapper<T>(),
  );
}