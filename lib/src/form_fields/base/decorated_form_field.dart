
import 'package:flutter/material.dart';
import '../../../foo_form_field.dart';
import '../../common/extentions/input_decoration_extension.dart';

class DecoratedFormField<Value, FieldValue> extends FooFormField<Value, FieldValue> {
  DecoratedFormField({
    super.key,
    required super.controller,
    super.properties,
    super.stateProvider,
    required void Function(BuildContext context)? onTap,
    required DecorationBuilder<FieldValue>? decorationBuilder,
    required FooFormFieldBuilder<FieldValue> builder,
  }) : super(
    builder: (BuildContext context, FooFormFieldState<FieldValue> fieldState) {
      
      var effectiveDecoration = decorationBuilder?.call(fieldState) ?? InputDecoration();

      effectiveDecoration = effectiveDecoration.merge(
        secondary: InputDecoration(
          errorText: fieldState.errorText,
          enabled: fieldState.enabled,
        ),
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
