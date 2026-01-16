import '../../../foo_form_field.dart';

class IntTextEditingController extends FooTextEditingController<int> {

  IntTextEditingController({
    super.initialValue,
  }):super(
    areEqual: (int x, int y) => x == y,
  );

  @override
  String? toText(int? value) => value?.toString();

  @override
  int? fromText(String? text) => int.tryParse(text ?? '');

}

class IntRangeTextEditingController extends FooRangeTextEditingController<int, IntTextEditingController>{
  
  IntRangeTextEditingController({
    int? initialMin,
    int? initialMax,
  }):super(
    minController: IntTextEditingController(
      initialValue: initialMin,
    ),
    maxController: IntTextEditingController(
      initialValue: initialMax,
    ),
  );
}