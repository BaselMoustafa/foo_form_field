import 'package:foo_form_field/foo_form_field.dart';

class ConvertableRangeBoundryFieldController<O,I> extends FooFieldController<O,I> {
  ConvertableRangeBoundryFieldController({
    required bool isMin,
    required ConvertableRangeFieldController<O,I,ConvertableRangeBoundryFieldController<O,I>> rangeFieldController,
  }):super(
    forcedErrorText: null,
    areEqual: rangeFieldController.areEqualValues,
    enabled: rangeFieldController.enabled,
    initialValue: isMin ? rangeFieldController.value?.min : rangeFieldController.value?.max,
    mapper: rangeFieldController.valueMapper,
  );
}