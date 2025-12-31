import 'package:flutter/material.dart';

import '../../foo_form_field.dart';

class TimeOfDayFormField extends StatelessWidget {
  const TimeOfDayFormField({
    super.key,
    required this.controller,
    this.properties,
    this.timeFormatter,
    this.builder,
    this.onTap,
    this.decoration,
  });

  /// Controller managing the selected time.
  final TimeOfDayFieldController controller;

  /// Formats the current time when using the default builder.
  final String? Function(TimeOfDay? time)? timeFormatter;

  /// Custom widget builder overriding the decorated default.
  final Widget Function(BuildContext context, TimeOfDay? value)? builder;

  /// Optional tap handler; when omitted a time picker is presented.
  final void Function(BuildContext context)? onTap;
  final InputDecoration? decoration;
  final FooFormFieldProperties<TimeOfDay>? properties;

  @override
  Widget build(BuildContext context) {
    return DecoratedValueFormField<TimeOfDay>(
      controller: controller,
      properties: properties,
      decoration: _effectiveDecoration,
      onTap: _onTap,
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, TimeOfDay? value) {
    
    if(builder != null) {
      return builder!(context, value);
    }

    return FittedBox(
      alignment: AlignmentDirectional.centerStart,
      fit: BoxFit.scaleDown,
      child: Text(
        timeFormatter?.call(value) ??
            "${value?.hour.toString().padLeft(2, '0')}:${value?.minute.toString().padLeft(2, '0')}",
        textAlign: TextAlign.start,
      ),
    );
  }

  /// Handles tap by delegating to custom handler or default time picker.
  void _onTap(BuildContext context) async {
    if (onTap != null) {
      onTap?.call(context);
      return;
    }

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: controller.value ?? TimeOfDay.now(),
    );

    if(selectedTime == null) {
      return;
    }

    controller.value = selectedTime;
  }

  /// Applies default icons to the provided decoration if missing.
  InputDecoration get _effectiveDecoration {
    if (decoration == null) {
      return InputDecoration(
        prefixIcon: Icon(Icons.access_time),
        suffixIcon: controller.value != null
            ? _ClearButton(controller: controller)
            : null,
      );
    }

    InputDecoration toReturn = decoration!;

    if (toReturn.prefixIcon == null) {
      toReturn = toReturn.copyWith(prefixIcon: Icon(Icons.access_time));
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

/// Button that clears the selected time.
class _ClearButton extends StatelessWidget {
  const _ClearButton({required this.controller});
  final FooFieldController<TimeOfDay, TimeOfDay> controller;

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

