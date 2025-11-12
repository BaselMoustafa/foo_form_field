import 'package:flutter/material.dart';
import 'package:foo_form_field/src/core/controllers/implementations/date_field_controller.dart';
import 'package:foo_form_field/src/form_fields/base/decorated_value_form_field.dart';

class DateFormField extends DecoratedValueFormField<DateTime> {
  DateFormField({
    super.key,
    required DateFieldController super.controller,
    String? Function(DateTime? date)? dateFormatter,
    Widget Function(BuildContext context)? builder,
    void Function(BuildContext context)? onTap,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    InputDecoration? decoration,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    super.errorBuilder,
    super.restorationId,
    super.onChanged,
  }):super(
    decoration: decoration?.prefixIcon==null? decoration?.copyWith(
      prefixIcon: Icon(Icons.calendar_today),
    ) : decoration,
    onTap: onTap?? (context) async{
      final selectedDate = await showDatePicker(
        context: context,
        initialDate: controller.value?? DateTime.now(),
        firstDate: firstDate?? DateTime(1900),
        lastDate: lastDate?? DateTime(2100),
      );

      if (selectedDate != null) {
        controller.value = selectedDate;
      }
    },
    builder: builder?? (BuildContext context) {
      final value = controller.value;
      return Row(
        spacing: 10,
        children: [
          Expanded(
            child: Text(
              dateFormatter?.call(value)?? "${value?.year}-${value?.month}-${value?.day}",
            ),
          ),
         
          InkWell(
            onTap: () {
              controller.clear();
            },
            child: const Icon(
              Icons.clear,
            ),
          ),
        ],
      );
    },
  );
}
