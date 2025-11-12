part of '../exporter.dart';

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

class IntStringRangeBoundryFieldController extends ConvertableRangeBoundryFieldController<int,String> {
  IntStringRangeBoundryFieldController({
    required super.isMin,
    required super.rangeFieldController,
  });
}

class IntStringRangeFieldController extends ConvertableRangeFieldController<int,String,IntStringRangeBoundryFieldController> {
  IntStringRangeFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }):super(
    valueMapper: IntStringMapper(),
    areEqualValues: (int x, int y) => x == y,
    minBoundryControllerBuilder: (rangeController) => IntStringRangeBoundryFieldController(
      isMin: true,
      rangeFieldController: rangeController
    ),
    maxBoundryControllerBuilder: (rangeController) => IntStringRangeBoundryFieldController(
      isMin: false,
      rangeFieldController: rangeController
    ),
  );
}