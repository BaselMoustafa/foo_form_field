part of '../exporter.dart';

/// Generic range form field that renders min/max inputs backed by a convertible controller.
class ConvertableRangeFormField<O,I> extends StatelessWidget {
  const ConvertableRangeFormField({
    super.key,
    required this.controller,
    required this.rangeValidator,
    required this.minFieldBuilder,
    required this.maxFieldBuilder,
    this.layoutBuilder,
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.restorationId,
    this.onChanged,
  });

  /// Shared controller keeping the min/max widgets in sync.
  final ConvertableRangeFieldController<O, I> controller;

  /// Validates the relationship between the min and max values.
  final RangeValidator<O> rangeValidator;

  /// Builder for the minimum value widget, given its controller and field value.
  final Widget Function(BuildContext context,I? value)minFieldBuilder;

  /// Builder for the maximum value widget, given its controller and field value.
  final Widget Function(BuildContext context, I? value)
  maxFieldBuilder;

  /// Optional layout wrapper around the min/max widgets.
  final Widget Function(BuildContext context, Widget minField, Widget maxField)?
  layoutBuilder;

  /// Called when the form saves with the composed range value.
  final void Function(Range<O?>? value)? onSaved;

  /// Additional validation applied after range-specific checks.
  final String? Function(Range<O?>? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final String? restorationId;

  /// Notifies listeners when the composed range changes.
  final void Function(Range<O?>? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return FooFormField<Range<O>, Range<I>>(
      builder: _builder,
      controller: controller,
      onSaved: onSaved,
      autovalidateMode: autovalidateMode,
      restorationId: restorationId,
      onChanged: onChanged,
      validator: _validator,
    );
  }

  /// Runs equality and min validations before delegating to the optional validator.
  String? _validator(Range<O>? value) {
    if (value == null) {
      return validator?.call(value);
    }

    String? equalityError = rangeValidator.validateEquality(value);
    if (equalityError != null) {
      return equalityError;
    }

    String? minError = rangeValidator.validateMin(value);
    if (minError != null) {
      return minError;
    }

    return validator?.call(value);
  }

  /// Builds the inner field layout, wrapping it with error presentation.
  Widget _builder(BuildContext context, Range<I>? value) {
    final minField = minFieldBuilder(
      context,
      value?.min,
    );
    final maxField = maxFieldBuilder(
      context,
      value?.max,
    );

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
