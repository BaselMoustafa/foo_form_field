
import '../../../core/models/mapper.dart';
import '../foo_form_field/foo_field_controller.dart';

class ValueFieldController<T> extends FooFieldController<T, T> {

  ValueFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    required super.areEqual,
  }) : super(mapper: Mapper.sameValueMapper<T>());
  
}
