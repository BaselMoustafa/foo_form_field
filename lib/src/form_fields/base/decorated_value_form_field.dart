
import 'package:flutter/material.dart';

import '../../common/models/foo_form_field_state.dart';
import 'foo_form_field.dart';

class DecoratedValueFormField<T> extends FooFormField<T, T> {
  DecoratedValueFormField({
    super.key,
    required super.controller,
    super.properties,
    required void Function(BuildContext context)? onTap,
    required InputDecoration? decoration,
    required Widget Function(BuildContext context, FooFormFieldState<T> fieldState) builder,
  }) : super(
    builder: (BuildContext context, FooFormFieldState<T> fieldState) {
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
