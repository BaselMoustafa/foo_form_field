import 'package:flutter/material.dart';
import 'package:foo_form_field/src/form_fields/base/value_form_field.dart';

class DecoratedValueFormField<T> extends ValueFormField<T> {
  DecoratedValueFormField({
    super.key,
    required super.controller,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    super.errorBuilder,
    super.restorationId,
    super.onChanged,
    required void Function(BuildContext context)? onTap,
    required InputDecoration? decoration,
    required Widget Function(BuildContext context) builder,
  }):super(
    builder: (BuildContext context) {
      var effectiveDecoration = (decoration?? InputDecoration());
      effectiveDecoration = effectiveDecoration.applyDefaults(Theme.of(context).inputDecorationTheme);
      effectiveDecoration = effectiveDecoration.copyWith(
        errorText: controller.errorText,
        enabled: controller.enabled,
      );

      return GestureDetector(
        onTap: controller.enabled?() => onTap?.call(context):null,
        child: InputDecorator(
          isEmpty: controller.value == null,
          decoration: effectiveDecoration,
          child:controller.value != null? builder(context) : null,
        ),
      );
    },
  );

}