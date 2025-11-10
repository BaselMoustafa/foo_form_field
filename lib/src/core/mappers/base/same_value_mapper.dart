import 'package:foo_form_field/src/core/mappers/base/field_value_mapper.dart';

class SameValueMapper<T> extends FieldValueMapper<T,T> {
  
  SameValueMapper():super(
    toClientType: (i) => i,
    toFieldType: (o) => o,
  );
}