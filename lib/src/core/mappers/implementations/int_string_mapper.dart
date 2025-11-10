import 'package:foo_form_field/src/core/mappers/base/field_value_mapper.dart';

class IntStringMapper extends FieldValueMapper<int,String> {
  IntStringMapper():super(
    toClientType: (String? text)=> text != null ? int.tryParse(text) : null,
    toFieldType: (int? value)=>value?.toString(),
  );
}