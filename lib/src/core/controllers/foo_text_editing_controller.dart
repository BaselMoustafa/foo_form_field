import 'package:foo_form_field/foo_form_field.dart';

class FooTextEditingController<O> extends FooFieldController<O,String> {
  FooTextEditingController({
    super.initialValue,
    super.enabled,
    required super.fromFieldValue,
    super.forcedErrorText,
    String? Function(O? value)? toFieldValue,
  }):super(
    toFieldValue:toFieldValue?? (O? value) {
      if (value == null) {
        return null;
      }
      return value.toString();
    },
  );
  
}

class StringTextEditingController extends FooTextEditingController<String> {
  
  StringTextEditingController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }):super(
    fromFieldValue: (String? text)=>text,
  );
  
}

class IntegerTextEditingController extends FooTextEditingController<int> {
  IntegerTextEditingController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }):super(
    fromFieldValue: (String? text)=>int.tryParse(text?? ""),
  );
}

class NumberTextEditingController extends FooTextEditingController<double> {
  NumberTextEditingController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }):super(
    fromFieldValue: (String? text)=>double.tryParse(text?? ""),
  );
}