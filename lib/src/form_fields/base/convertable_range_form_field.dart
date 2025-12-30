
import 'package:flutter/material.dart';
import '../../common/models/foo_form_field_properties.dart';
import '../../common/ranges/range_validators.dart';
import '../../common/ranges/ranges.dart';
import '../../common/widgets/field_with_error_text_widget.dart';
import '../../controllers/base/foo_field_controller.dart';
import 'foo_form_field.dart';
import '../../controllers/base/convertable_range_field_controller.dart';

/// Generic range form field that renders min/max inputs backed by a convertible controller.
class ConvertableRangeFormField<O, I, BoundryController extends FooFieldController<O, I>> extends StatelessWidget {
  const ConvertableRangeFormField({
    super.key,
    required this.controller,
    required this.rangeValidator,
    required this.minFieldBuilder,
    required this.maxFieldBuilder,
    this.layoutBuilder,
    this.properties
  });

  final ConvertableRangeFieldController<O, I, BoundryController> controller;

  final RangeValidator<O> rangeValidator;

  final Widget Function(BuildContext context, I? value) minFieldBuilder;
  
  final Widget Function(BuildContext context, I? value) maxFieldBuilder;

  final Widget Function(BuildContext context, Widget minField, Widget maxField)? layoutBuilder;

  final FooFormFieldProperties<Range<O>>? properties;

  FooFormFieldProperties<Range<O>> get _properties{
    return properties ?? FooFormFieldProperties<Range<O>>();
  }

  @override
  Widget build(BuildContext context) {
    return FooFormField<Range<O>, Range<I>>(
      builder: _builder,
      controller: controller,
      properties: _properties.copyWith(
        validator: _validator
      ),
    );
  }

  /// Runs equality and min validations before delegating to the optional validator.
  String? _validator(Range<O>? value) {
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
  Widget _builder(BuildContext context, Range<I>? value) {
    final minField = minFieldBuilder(context, value?.min);
    final maxField = maxFieldBuilder(context, value?.max);

    return FieldWithErrorTextWidget(
      errorText: controller.errorText,
      fieldWidget:
          layoutBuilder?.call(context, minField, maxField) ??
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
