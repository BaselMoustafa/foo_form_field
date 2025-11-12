part of '../exporter.dart';

class ValueFieldController<T> extends ConvertableValueFieldController<T,T> {

  ValueFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    required super.areEqual, 
  }): super(
    mapper: SameValueMapper<T>(),
  );
}