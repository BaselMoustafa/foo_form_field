import 'package:flutter/material.dart';
import 'package:foo_form_field/src/core/controllers/implementations/date_field_controller.dart';
import 'package:foo_form_field/src/form_fields/base/decorated_value_form_field.dart';

class DateFormField extends DecoratedValueFormField<DateTime> {
  DateFormField({
    super.key,
    required DateFieldController super.controller,
    String? Function(DateTime? date)? dateFormatter,
    Widget Function(BuildContext context)? builder,
    super.decoration,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    super.errorBuilder,
    super.restorationId,
    super.onChanged,
  }):super(
    builder: builder?? (BuildContext context) {
      final value = controller.value;
      return Row(
        spacing: 10,
        children: [
          Text(
            dateFormatter?.call(value)?? "${value?.year}-${value?.month}-${value?.day}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
         
          IconButton(
            onPressed: () {
              controller.clear();
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      );
    },
  );
}
