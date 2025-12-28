
import 'package:flutter/material.dart';

import '../../form_fields/base/foo_form_field/foo_form_field.dart';

class DecoratedValueFormField<T> extends FooFormField<T, T> {
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
    required Widget Function(BuildContext context, T? value) builder,
  }) : super(
         builder: (BuildContext context, T? value) {
           var effectiveDecoration = (decoration ?? InputDecoration());
           effectiveDecoration = effectiveDecoration.applyDefaults(
             Theme.of(context).inputDecorationTheme,
           );
           effectiveDecoration = effectiveDecoration.copyWith(
             errorText: controller.errorText,
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
                     ? builder(context, value)
                     : null,
               ),
             ),
           );
         },
       );
}
