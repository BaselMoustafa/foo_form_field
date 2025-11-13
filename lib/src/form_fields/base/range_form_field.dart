part of '../exporter.dart';

/// Convenience wrapper when the range field has matching input/output types.
class RangeFormField<T> extends ConvertableRangeFormField<T, T> {
  const RangeFormField({
    super.key,
    required RangeFieldController<T> super.controller,
    required super.minFieldBuilder,
    required super.maxFieldBuilder,
    required super.rangeValidator,
    super.layoutBuilder,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    super.restorationId,
    super.onChanged,
  });
}
