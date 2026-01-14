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

  FooFormFieldProperties<Value> copyWith({
    AutovalidateMode? autovalidateMode,
    FormFieldErrorBuilder? errorBuilder,
    String? restorationId,
    void Function(Value? value)? onChanged,
    String? Function(Value? value)? validator,
    void Function(Value? value)? onSaved,
    String? forceErrorText,
  }) {
    return FooFormFieldProperties(
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      errorBuilder: errorBuilder ?? this.errorBuilder,
      restorationId: restorationId ?? this.restorationId,
      onChanged: onChanged ?? this.onChanged,
      validator: validator ?? this.validator,
      onSaved: onSaved ?? this.onSaved,
      forceErrorText: forceErrorText ?? this.forceErrorText,
    );
  }
}