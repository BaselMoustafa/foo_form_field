import '../../../foo_form_field.dart';

class FooTextEditingController<Value> extends FooFieldController<Value, String> {
  FooTextEditingController({
    required super.initialValue,
    required super.enabled,
    required super.forcedErrorText,
    required super.mapper,
  }) : super(
    areEqual: (Value x, Value y){
      String? xString = mapper.toFieldValue(x);
      String? yString = mapper.toFieldValue(y);
      return xString == yString;
    },
  );
}

class FooRangeTextEditingController<
  Value,
  BoundryController extends FooTextEditingController<Value>
> extends ConvertableRangeFieldController<Value, String,BoundryController> {

  FooRangeTextEditingController({
    required super.minController,
    required super.maxController,
    required super.areEqualValues,
    required super.mapper,
    super.enabled,
    super.forcedErrorText,
  });
}