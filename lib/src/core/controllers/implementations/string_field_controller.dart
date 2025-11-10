import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/core/mappers/base/same_value_mapper.dart';

class StringFieldController extends ValueFieldController<String> {
  
  StringFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }):super(
    mapper: SameValueMapper<String>(),
    areEqual: (String x, String y) => x == y,
  );
}