import 'package:foo_form_field/src/core/controllers/base/convertable_value_field_controller.dart';
import 'package:foo_form_field/src/core/mappers/implementations/int_string_mapper.dart';

class IntStringFieldController extends ConvertableValueFieldController<int,String> {
  
  IntStringFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }):super(
    areEqual: (int x, int y) => x == y,
    mapper: IntStringMapper(),
  );
}