import 'package:flutter/material.dart';

import '../../foo_form_field.dart';
import '../common/extentions/input_decoration_extension.dart';

class TimeOfDayFormField extends StatelessWidget {
  const TimeOfDayFormField({
    super.key,
    required this.controller,
    this.properties,
    this.timeFormatter,
    this.builder,
    this.onTap,
    this.decorationBuilder,
    this.stateProvider,
  });

  /// Controller managing the selected time.
  final TimeOfDayFieldController controller;

  /// Formats the current time when using the default builder.
  final String? Function(TimeOfDay? time)? timeFormatter;

  /// Custom widget builder overriding the decorated default.
  final FooFormFieldBuilder<TimeOfDay>? builder;

  /// Optional tap handler; when omitted a time picker is presented.
  final void Function(BuildContext context)? onTap;
  final DecorationBuilder<TimeOfDay>? decorationBuilder;
  final FooFormFieldProperties<TimeOfDay>? properties;
  final FooFormFieldStateProvider<TimeOfDay>? stateProvider;

  @override
  Widget build(BuildContext context) {
    if(builder != null) {
      return FooFormField(
        controller: controller,
        properties: properties,
        builder: builder!,
        stateProvider: stateProvider,
      );
    }
    return DecoratedFormField(
      controller: controller,
      properties: properties,
      stateProvider: stateProvider,
      decorationBuilder: _effectiveDecorationBuilder,
      onTap: _onTap,
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, FooFormFieldState<TimeOfDay> fieldState) {
    
    final value = fieldState.value;

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
  InputDecoration _effectiveDecorationBuilder(FooFormFieldState<TimeOfDay> fieldState) {
    InputDecoration toReturn = decorationBuilder?.call(fieldState) ?? InputDecoration();
    toReturn = toReturn.merge(
      secondary: InputDecoration(
        prefixIcon: Icon(Icons.access_time),
        suffixIcon: controller.value != null
            ? CloseButton(
              onPressed: () => controller.clear(),
            )
            : null,
      ),
    );
    return toReturn;
  }
}
