import '../../../foo_form_field.dart';

class NumTextEditingController extends FooTextEditingController<num> {

  NumTextEditingController({
    super.initialValue,
  }):super(
    areEqual: (num x, num y) => x == y,
  );

  @override
  String? toText(num? value) => value?.toString();

  @override
  num? fromText(String? text) => num.tryParse(text ?? '');

}

class NumRangeTextEditingController extends FooRangeTextEditingController<num, NumTextEditingController>{
  
  NumRangeTextEditingController({
    required super.minController,
    required super.maxController,
  });
}
