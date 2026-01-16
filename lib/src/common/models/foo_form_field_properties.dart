import 'package:flutter/material.dart';

class FooFormFieldProperties<Value> {
  
  final AutovalidateMode? autovalidateMode;
  final FormFieldErrorBuilder? errorBuilder;
  final String? restorationId;
  final void Function(Value? value)? onChanged;
  final String? Function(Value? value)? validator;
  final void Function(Value? value)? onSaved;
  final String? forceErrorText;

  const FooFormFieldProperties({
    this.autovalidateMode,
    this.errorBuilder,
    this.restorationId,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.forceErrorText,
  });

}