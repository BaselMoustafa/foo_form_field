import 'base/value_field_controller.dart';

class BoolFieldController extends ValueFieldController<bool> {
  BoolFieldController({
    super.initialValue,
    super.enabled,
  }) : super(areEqual: (bool x, bool y) => x == y);
}
