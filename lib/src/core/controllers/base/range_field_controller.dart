

import 'package:foo_form_field/src/core/controllers/base/convertable_range_field_controller.dart';
import 'package:foo_form_field/src/core/mappers/base/same_value_mapper.dart';

class RangeFieldController<T> extends ConvertableRangeFieldController<T,T> {
  RangeFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    required super.areEqual,
  }):super(
    valueMapper: SameValueMapper<T>(),
  );
}
