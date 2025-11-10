import 'package:foo_form_field/foo_form_field.dart';

class ConvertableValueFieldController<O,I> extends FooFieldController<O,I> {
  ConvertableValueFieldController({
    required super.areEqual,
    required super.enabled,
    required super.forcedErrorText,
    required super.initialValue,
    required super.mapper,
  });
}