import '../../../foo_form_field.dart';

class StringTextEditingController extends FooTextEditingController<String> {
  
  StringTextEditingController({
    super.initialValue,
  }):super(
    areEqual: (String x, String y) => x == y,
  );

  @override
  String? toText(String? value) => value;

  @override
  String? fromText(String? text) => text;
}