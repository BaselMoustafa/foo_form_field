part of '../exporter.dart';

class RangeFormField<T,B extends RangeBoundryFieldController<T>> extends ConvertableRangeFormField<T,T,B> {
  
  const RangeFormField({
    super.key,
    required RangeFieldController<T,B> super.controller,
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