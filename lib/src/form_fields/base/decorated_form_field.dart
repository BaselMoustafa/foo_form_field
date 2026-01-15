
import 'package:flutter/material.dart';

import '../../../foo_form_field.dart';

class DecoratedFormField<Value, FieldValue> extends FooFormField<Value, FieldValue> {
  DecoratedFormField({
    super.key,
    required super.controller,
    super.properties,
    required void Function(BuildContext context)? onTap,
    required InputDecoration? decoration,
    required FooFormFieldBuilder<FieldValue> builder,
  }) : super(
    builder: (BuildContext context, FooFormFieldState<FieldValue> fieldState) {
      
      var effectiveDecoration = decoration ?? InputDecoration();
      
      effectiveDecoration = effectiveDecoration.applyDefaults(
        Theme.of(context).inputDecorationTheme,
      );

      effectiveDecoration = effectiveDecoration.copyWith(
        errorText: fieldState.errorText,
        enabled: fieldState.enabled,
      );

      return AbsorbPointer(
        absorbing: !fieldState.enabled,
        child: GestureDetector(
          onTap: () => onTap?.call(context),
          child: InputDecorator(
            textAlignVertical: TextAlignVertical.center,
            isEmpty: controller.value == null,
            decoration: effectiveDecoration,
            child: controller.value != null
                ? builder(context, fieldState)
                : null,
          ),
        ),
      );
    },
  );
}
