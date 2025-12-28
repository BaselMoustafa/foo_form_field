import '../../../base/value_form_field/value_field_controller.dart';

class BoolFieldController extends ValueFieldController<bool> {
  BoolFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }) : super(areEqual: (bool x, bool y) => x == y);
}
