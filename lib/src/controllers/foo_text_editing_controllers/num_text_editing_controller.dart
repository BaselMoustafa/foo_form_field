import '../../../foo_form_field.dart';

class NumTextEditingController extends FooTextEditingController<num> {

  NumTextEditingController({
    super.initialValue,
  }):super(
    mapper: NumToStringMapper()
  );

}

class NumRangeTextEditingController extends FooRangeTextEditingController<num, NumTextEditingController>{
  
  NumRangeTextEditingController({
    required super.minController,
    required super.maxController,
  }):super(
    mapper: NumRangeToStringRangeMapper(),
  );
}
