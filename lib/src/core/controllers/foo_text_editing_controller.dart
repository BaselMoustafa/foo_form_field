import 'package:foo_form_field/foo_form_field.dart';

class FooTextEditingController<O> extends ConvertableValueFieldController<O,String> {
  FooTextEditingController({
    super.initialValue,
    super.enabled,
    required super.fromFieldValue,
    String? Function(O? value)? toFieldValue,
  }):super(
    toFieldValue:toFieldValue?? (O? value) {
      return value.toString();
    },
  );
  
}

class StringTextEditingController extends FooTextEditingController<String> {
  
  StringTextEditingController({
    super.initialValue,
    super.enabled,
  }):super(
    fromFieldValue: (String? text)=>text,
  );
  
}

class IntegerTextEditingController extends FooTextEditingController<int> {
  IntegerTextEditingController({
    super.initialValue,
    super.enabled,
  }):super(
    fromFieldValue: (String? text)=>int.tryParse(text?? ""),
  );
}

class NumberTextEditingController extends FooTextEditingController<double> {
  NumberTextEditingController({
    super.initialValue,
    super.enabled,
  }):super(
    fromFieldValue: (String? text)=>double.tryParse(text?? ""),
  );
}