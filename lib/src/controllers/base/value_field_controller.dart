
import '../../../foo_form_field.dart';

class ValueFieldController<T> extends FooFieldController<T, T> {

  ValueFieldController({
    super.initialValue,
    required super.areEqual,
  }) : super(
    mapper: Mapper.sameValueMapper<T>(),
  );
  
}
