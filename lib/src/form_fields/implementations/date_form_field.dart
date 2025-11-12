import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/form_fields/base/decorated_value_form_field.dart';

class DateFormField extends StatelessWidget{

  const DateFormField({
    super.key,
    required this.controller,
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.errorBuilder,
    this.restorationId,
    this.onChanged,
    this.dateFormatter,
    this.builder,
    this.onTap,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.decoration,
  });

  final FooFieldController<DateTime,DateTime> controller;
  final String? Function(DateTime? date)? dateFormatter;
  final Widget Function(BuildContext context)? builder;
  final void Function(BuildContext context)? onTap;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final InputDecoration? decoration;
  final void Function(DateTime? value)? onSaved;
  final String? Function(DateTime? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final FormFieldErrorBuilder? errorBuilder;
  final String? restorationId;
  final void Function(DateTime? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedValueFormField<DateTime>(
      controller: controller, 
      onSaved: onSaved,
      validator: validator,
      autovalidateMode: autovalidateMode,
      errorBuilder: errorBuilder,
      restorationId: restorationId,
      onChanged: onChanged,
      decoration: _effectiveDecoration,
      onTap: _onTap,
      builder: builder?? (BuildContext context) {
        final value = controller.value;
        return FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            dateFormatter?.call(value)?? "${value?.year}-${value?.month}-${value?.day}",
          ),
        );
      },
    );
  }

  void _onTap(BuildContext context) async{
    if (onTap!=null) {
      onTap?.call(context);
      return;
    }

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: controller.value?? DateTime.now(),
      firstDate: firstDate?? DateTime(1900),
      lastDate: lastDate?? DateTime(2100),
    );

    if (selectedDate != null) {
      controller.value = selectedDate;
    }
  }

  InputDecoration get _effectiveDecoration {
    if(decoration==null) {
      return InputDecoration(
        prefixIcon: Icon(Icons.calendar_today),
        suffixIcon: controller.value!=null? _ClearButton(controller: controller) : null,
      );
    }

    InputDecoration toReturn = decoration!;

    if (toReturn.prefixIcon==null) {
      toReturn = toReturn.copyWith(
        prefixIcon: Icon(Icons.calendar_today),
      );
    }

    if (toReturn.suffixIcon==null) {
      toReturn = toReturn.copyWith(
        suffixIcon: controller.value!=null? _ClearButton(controller: controller) : null,
      );
    }

    return toReturn;
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({required this.controller});
  final FooFieldController<DateTime,DateTime> controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.clear();
      },
      child: Icon(Icons.clear),
    );
  }
}
