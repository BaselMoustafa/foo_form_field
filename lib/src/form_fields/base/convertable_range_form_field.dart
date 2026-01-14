
import 'package:flutter/material.dart';
import '../../common/models/controlled_field_state.dart';
import '../../common/models/foo_form_field_properties.dart';
import '../../common/ranges/range_validators.dart';
import '../../common/ranges/ranges.dart';
import '../../common/widgets/field_with_error_text_widget.dart';
import '../../controllers/base/foo_field_controller.dart';
import 'foo_form_field.dart';
import '../../controllers/base/convertable_range_field_controller.dart';

/// Generic range form field that renders min/max inputs backed by a convertible controller.
class ConvertableRangeFormField<
  Value extends Comparable, 
  FieldValue extends Comparable, 
  BoundryController extends FooFieldController<Value, FieldValue>,
  RangeController extends ConvertableRangeFieldController<Value, FieldValue, BoundryController>
> extends StatelessWidget {
  const ConvertableRangeFormField({
    super.key,
    required this.controller,
    RangeValidator? rangeValidator,
    required this.minFieldBuilder,
    required this.maxFieldBuilder,
    this.builder,
    this.properties
  }):rangeValidator = rangeValidator ?? const RangeValidator();

  final RangeController controller;

  final RangeValidator rangeValidator;

  final Widget Function(BuildContext context, FieldValue? value) minFieldBuilder;
  
  final Widget Function(BuildContext context, FieldValue? value) maxFieldBuilder;

  final Widget Function(BuildContext context, ControlledFieldState<Range<Value>, Range<FieldValue>> controlledFieldState, Widget minField, Widget maxField)? builder;

  final FooFormFieldProperties<Range<Value>>? properties;

  FooFormFieldProperties<Range<Value>> get _properties{
    return properties ?? FooFormFieldProperties<Range<Value>>();
  }

  @override
  Widget build(BuildContext context) {
    return FooFormField<Range<Value>, Range<FieldValue>>(
      builder: (BuildContext context, ControlledFieldState<Range<Value>, Range<FieldValue>> controlledFieldState) {
        return _builder(context, controlledFieldState);
      },
      controller: controller,
      properties: _properties.copyWith(
        validator: _validator
      ),
    );
  }

  /// Runs equality and min validations before delegating to the optional validator.
  String? _validator(Range<Value>? value) {
    if (value == null) {
      return properties?.validator?.call(value);
    }

    String? equalityError = rangeValidator.validateEquality(value);

    if (equalityError != null) {
      return equalityError;
    }

    String? minError = rangeValidator.validateMin(value);
    if (minError != null) {
      return minError;
    }

    return properties?.validator?.call(value);
  }

  /// Builds the inner field layout, wrapping it with error presentation.
  Widget _builder(BuildContext context, ControlledFieldState<Range<Value>, Range<FieldValue>> controlledFieldState) {
    final minField = minFieldBuilder(context, controller.minController.fieldValue);
    final maxField = maxFieldBuilder(context, controller.maxController.fieldValue);

    return FieldWithErrorTextWidget(
      errorText: controlledFieldState.errorText,
      fieldWidget:
          builder?.call(context, controlledFieldState, minField, maxField) ??
          Row(
            spacing: 10,
            children: [
              Expanded(child: minField),
              Expanded(child: maxField),
            ],
          ),
    );
  }
}
