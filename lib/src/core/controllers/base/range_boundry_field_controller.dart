import 'package:foo_form_field/foo_form_field.dart';
class RangeBoundryFieldController<T> extends ConvertableRangeBoundryFieldController<T,T> {
  
  RangeBoundryFieldController({
    required super.isMin,
    required super.rangeFieldController,
  });
}