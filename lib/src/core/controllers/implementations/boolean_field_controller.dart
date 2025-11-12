part of '../exporter.dart';

class BooleanFieldController extends ValueFieldController<bool> {
  BooleanFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }):super(
    areEqual: (bool x, bool y) => x == y,
  );
}