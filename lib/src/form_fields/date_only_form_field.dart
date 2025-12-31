import 'package:flutter/material.dart';
import '../../foo_form_field.dart';

class DateOnlyFormField extends StatelessWidget {
  const DateOnlyFormField({
    super.key,
    required this.controller,
    this.properties,
    this.dateFormatter,
    this.builder,
    this.onTap,
    this.firstDate,
    this.lastDate,
    this.decoration,
  });

  /// Controller managing the selected date.
  final DateOnlyFieldController controller;

  /// Formats the current date when using the default builder.
  final String? Function(DateOnly? date)? dateFormatter;

  /// Custom widget builder overriding the decorated default.
  final Widget Function(BuildContext context, DateOnly? value)? builder;

  /// Optional tap handler; when omitted a date picker is presented.
  final void Function(BuildContext context)? onTap;
  final DateOnly? firstDate;
  final DateOnly? lastDate;
  final InputDecoration? decoration;
  final FooFormFieldProperties<DateOnly>? properties;

  @override
  Widget build(BuildContext context) {
    return DecoratedValueFormField<DateOnly>(
      controller: controller,
      properties: properties,
      decoration: _effectiveDecoration,
      onTap: _onTap,
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, DateOnly? value) {
    
    if(builder != null) {
      return builder!(context, value);
    }

    return FittedBox(
      alignment: AlignmentDirectional.centerStart,
      fit: BoxFit.scaleDown,
      child: Text(
        dateFormatter?.call(value) ??
            "${value?.year}-${value?.month}-${value?.day}",
        textAlign: TextAlign.start,
      ),
    );
  }

  /// Handles tap by delegating to custom handler or default date picker.
  void _onTap(BuildContext context) async {
    if (onTap != null) {
      onTap?.call(context);
      return;
    }

    final initialDate = controller.value?.toDateTime();

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate?.toDateTime() ?? DateTime(1900),
      lastDate: lastDate?.toDateTime() ?? DateTime(2100),
    );

    if(selectedDate == null) {
      return;
    }

    controller.value = DateOnly.fromDateTime(selectedDate);
  }

  /// Applies default icons to the provided decoration if missing.
  InputDecoration get _effectiveDecoration {
    if (decoration == null) {
      return InputDecoration(
        prefixIcon: Icon(Icons.calendar_today),
        suffixIcon: controller.value != null
            ? _ClearButton(controller: controller)
            : null,
      );
    }

    InputDecoration toReturn = decoration!;

    if (toReturn.prefixIcon == null) {
      toReturn = toReturn.copyWith(prefixIcon: Icon(Icons.calendar_today));
    }

    if (toReturn.suffixIcon == null) {
      toReturn = toReturn.copyWith(
        suffixIcon: controller.value != null
            ? _ClearButton(controller: controller)
            : null,
      );
    }

    return toReturn;
  }
}

/// Button that clears the selected date.
class _ClearButton extends StatelessWidget {
  const _ClearButton({required this.controller});
  final FooFieldController<DateOnly, DateOnly> controller;

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

