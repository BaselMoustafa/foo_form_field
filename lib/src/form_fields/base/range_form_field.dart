
import 'package:flutter/material.dart';
import '../../common/widgets/field_with_error_text_widget.dart';
import '../../../foo_form_field.dart';
typedef RangeFormFieldBuilder<FieldValue extends Comparable> = Widget Function(
  BuildContext context, Widget minField, Widget maxField, FooFormFieldState<Range<FieldValue>> fieldState
);

/// Generic range form field that renders min/max inputs backed by a convertible controller.
class RangeFormField<
  Value extends Comparable, 
  FieldValue extends Comparable, 
  BoundryController extends FooFieldController<Value, FieldValue>
> extends StatelessWidget {
  const RangeFormField({
    super.key,
    required this.controller,
    RangeValidator? rangeValidator,
    required this.minFieldBuilder,
    required this.maxFieldBuilder,
    this.builder,
    this.properties
  }):rangeValidator = rangeValidator ?? const RangeValidator();

  final ConvertableRangeFieldController<Value, FieldValue, BoundryController> controller;

  final RangeValidator rangeValidator;

  final Widget Function(BuildContext context, FieldValue? value) minFieldBuilder;
  
  final Widget Function(BuildContext context, FieldValue? value) maxFieldBuilder;

  final RangeFormFieldBuilder<FieldValue>? builder;

  final FooFormFieldProperties<Range<Value>>? properties;

  FooFormFieldProperties<Range<Value>> get _properties{
    return properties ?? FooFormFieldProperties<Range<Value>>();
  }

  @override
  Widget build(BuildContext context) {
    return FooFormField<Range<Value>, Range<FieldValue>>(
      builder: (BuildContext context, FooFormFieldState<Range<FieldValue>> fieldState) {
        return _builder(context, fieldState);
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
  Widget _builder(BuildContext context, FooFormFieldState<Range<FieldValue>> fieldState) {
    final minField = minFieldBuilder(context, controller.minController.fieldValue);
    final maxField = maxFieldBuilder(context, controller.maxController.fieldValue);

    if (builder != null) {
      return builder!(context, minField, maxField, fieldState);
    }

    return FieldWithErrorTextWidget(
      errorText: fieldState.errorText,
      fieldWidget: Row(
        spacing: 10,
        children: [
          Expanded(child: minField),
          Expanded(child: maxField),
        ],
      ),
    );
  }
}
