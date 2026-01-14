import '../../../foo_form_field.dart';

class StringTextEditingController extends FooTextEditingController<String> {
  
  StringTextEditingController({
    super.initialValue,
  }):super(
    mapper: Mapper.sameValueMapper<String>()
  );
}