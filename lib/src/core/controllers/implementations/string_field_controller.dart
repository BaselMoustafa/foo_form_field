part of '../exporter.dart';

class StringFieldController extends ValueFieldController<String> {
  
  StringFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }):super(
    areEqual: (String x, String y) => x == y,
  );
}