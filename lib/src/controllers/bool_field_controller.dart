import 'base/foo_field_controller.dart';

class BoolFieldController extends FooFieldController<bool> {
  BoolFieldController({
    super.initialValue,
  }) : super(areEqual: (bool x, bool y) => x == y) {
    value = initialValue;
  }
}
