import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/core/controllers/base/convertable_range_field_controller.dart';
import 'package:foo_form_field/src/core/controllers/base/range_boundry_field_controller.dart';
import 'package:foo_form_field/src/core/mappers/base/same_value_mapper.dart';

class RangeFieldController<T,B extends RangeBoundryFieldController<T>> extends ConvertableRangeFieldController<T,T,B> {
  RangeFieldController({
    required super.areEqualValues,
    required super.minBoundryControllerBuilder,
    required super.maxBoundryControllerBuilder,
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }):super(
    valueMapper: SameValueMapper<T>(),
  );
}
