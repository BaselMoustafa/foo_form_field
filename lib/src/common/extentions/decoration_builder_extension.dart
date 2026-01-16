import '../../../foo_form_field.dart';
import 'package:flutter/material.dart';

extension DecorationBuilderExtension<T> on DecorationBuilder<T>? {

  DecorationBuilder<T> merge({
    required DecorationBuilder<T>? secondaryBuilder,
  }) {
    return (fieldState) {
      var primaryDecoration = this?.call(fieldState) ?? InputDecoration();
      var secondaryDecoration = secondaryBuilder?.call(fieldState) ?? InputDecoration();

      return primaryDecoration.merge(
        secondary: secondaryDecoration,
      );
    };
  }
}