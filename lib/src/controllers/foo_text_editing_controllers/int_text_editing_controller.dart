import '../../../foo_form_field.dart';

class IntTextEditingController extends FooTextEditingController<int> {

  IntTextEditingController({
    super.initialValue,
  }):super(
    mapper: IntToStringMapper()
  );

}

class IntRangeTextEditingController extends FooRangeTextEditingController<int, IntTextEditingController>{
  
  IntRangeTextEditingController({
    required super.minController,
    required super.maxController,
  }):super(
    mapper: IntRangeToStringRangeMapper(),
  );
}