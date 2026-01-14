
import 'package:flutter/material.dart';

import '../../common/models/controlled_field_state.dart';
import 'foo_form_field.dart';

class DecoratedValueFormField<T> extends FooFormField<T, T> {
  DecoratedValueFormField({
    super.key,
    required super.controller,
    super.properties,
    required void Function(BuildContext context)? onTap,
    required InputDecoration? decoration,
    required Widget Function(BuildContext context, ControlledFieldState<T,T> controlledFieldState) builder,
  }) : super(
    builder: (BuildContext context, ControlledFieldState<T,T> controlledFieldState) {
      var effectiveDecoration = decoration ?? InputDecoration();
      effectiveDecoration = effectiveDecoration.applyDefaults(
        Theme.of(context).inputDecorationTheme,
      );
      effectiveDecoration = effectiveDecoration.copyWith(
        errorText: controlledFieldState.errorText,
        enabled: controller.enabled,
      );

      return AbsorbPointer(
        absorbing: !controller.enabled,
        child: GestureDetector(
          onTap: () => onTap?.call(context),
          child: InputDecorator(
            textAlignVertical: TextAlignVertical.center,
            isEmpty: controller.value == null,
            decoration: effectiveDecoration,
            child: controller.value != null
                ? builder(context, controlledFieldState)
                : null,
          ),
        ),
      );
    },
  );
}
