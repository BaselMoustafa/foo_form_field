import '../../../foo_form_field.dart';

class NumTextEditingController extends FooTextEditingController<num> {

  NumTextEditingController({
    super.initialValue,
    super.enabled,
  }):super(
    mapper: NumToStringMapper()
  );

}

class NumRangeTextEditingController extends FooRangeTextEditingController<num, NumTextEditingController>{
  
  NumRangeTextEditingController({
    required super.minController,
    required super.maxController,
    super.enabled,
  }):super(
    mapper: NumRangeToStringRangeMapper(),
  );
}
