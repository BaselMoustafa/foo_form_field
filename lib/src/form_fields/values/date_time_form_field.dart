import 'package:flutter/material.dart';
import '../../../foo_form_field.dart';
import '../../common/extentions/date_time_extension.dart';
import '../../common/extentions/input_decoration_extension.dart';

class DateTimeFormField extends StatelessWidget {
  const DateTimeFormField({
    super.key,
    required this.controller,
    this.properties,
    this.dateFormatter,
    this.builder,
    this.onTap,
    this.firstDate,
    this.lastDate,
    this.decorationBuilder,
    this.stateProvider,
  });

  /// Controller managing the selected date.
  final DateTimeFieldController controller;

  /// Formats the current date when using the default builder.
  final String? Function(DateTime? date)? dateFormatter;

  /// Custom widget builder overriding the decorated default.
  final FooFormFieldBuilder<DateTime>? builder;

  /// Optional tap handler; when omitted a date picker is presented.
  final void Function(BuildContext context)? onTap;

  final DateTime? firstDate;
  
  final DateTime? lastDate;
  
  final DecorationBuilder<DateTime>? decorationBuilder;
  
  final FooFormFieldProperties<DateTime>? properties;
  
  final FooFormFieldStateProvider<DateTime>? stateProvider;

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

  Widget _builder(BuildContext context, FooFormFieldState<DateTime> fieldState) {

    final value = fieldState.value;
    
    return FittedBox(
      alignment: AlignmentDirectional.centerStart,
      fit: BoxFit.scaleDown,
      child: Text(
        dateFormatter?.call(value) ??
          "${value?.hour}:${value?.minute} / ${value?.year}-${value?.month}-${value?.day}",
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

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: controller.value,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
    );

    if(selectedDate == null) {
      return;
    }

    final selectedTime = await showTimePicker(
      // ignore: use_build_context_synchronously
      context: context, 
      initialTime: controller.value?.timeOfDay ?? TimeOfDay.now(),
      
    );

    if (selectedTime == null) {
      return;
    }

    controller.value = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }

  /// Applies default icons to the provided decoration if missing.
  InputDecoration  _effectiveDecorationBuilder(FooFormFieldState<DateTime> fieldState) {
    InputDecoration toReturn = decorationBuilder?.call(fieldState) ?? InputDecoration();
    toReturn = toReturn.merge(
      secondary: InputDecoration(
        prefixIcon: Icon(Icons.timer),
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

