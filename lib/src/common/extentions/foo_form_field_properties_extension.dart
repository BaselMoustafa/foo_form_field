import 'package:flutter/material.dart';

import '../../../foo_form_field.dart';

extension FooFormFieldPropertiesExtension<Value> on FooFormFieldProperties<Value>? {
  
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
      autovalidateMode: autovalidateMode ?? this?.autovalidateMode,
      errorBuilder: errorBuilder ?? this?.errorBuilder,
      restorationId: restorationId ?? this?.restorationId,
      onChanged: onChanged ?? this?.onChanged,
      validator: validator ?? this?.validator,
      onSaved: onSaved ?? this?.onSaved,
      forceErrorText: forceErrorText ?? this?.forceErrorText,
    );
  }

  FooFormFieldProperties<Value> addRequiredValidator({
    required String message,
  }) {
    return copyWith(
      validator: (value) {
        if (value == null || value.toString().trim().isEmpty) {
          return message;
        }
        return this?.validator?.call(value);
      },
    );
  }

}