import '../../../foo_form_field.dart';

class IntTextEditingController extends FooTextEditingController<int> {

  IntTextEditingController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }):super(
    mapper: IntToStringMapper()
  );

}

class IntRangeTextEditingController extends FooRangeTextEditingController<int, IntTextEditingController>{
  
  IntRangeTextEditingController({
    required super.minController,
    required super.maxController,
    super.enabled,
    super.forcedErrorText,
  }):super(
    mapper: IntRangeToStringRangeMapper(),
    areEqualValues: (int x, int y) => x == y,
  );
}