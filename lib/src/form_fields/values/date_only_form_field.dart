import 'package:flutter/material.dart';

import '../../../foo_form_field.dart';

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
    this.decorationBuilder,
    this.stateProvider,
  });

  /// Controller managing the selected date.
  final DateOnlyFieldController controller;

  /// Formats the current date when using the default builder.
  final String? Function(DateOnly? date)? dateFormatter;

  /// Custom widget builder overriding the decorated default.
  final FooFormFieldBuilder<DateOnly>? builder;

  /// Optional tap handler; when omitted a date picker is presented.
  final void Function(BuildContext context)? onTap;
  final DateOnly? firstDate;
  final DateOnly? lastDate;
  final DecorationBuilder<DateOnly>? decorationBuilder;
  final FooFormFieldProperties<DateOnly>? properties;
  final FooFormFieldStateProvider<DateOnly>? stateProvider;

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
      onTap: _onTap,
      builder: _builder,
      decorationBuilder: _effectiveDecorationBuilder,
    );
  }

  Widget _builder(BuildContext context, FooFormFieldState<DateOnly> fieldState) {
    
    final value = fieldState.value;

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
  InputDecoration _effectiveDecorationBuilder(FooFormFieldState<DateOnly> fieldState) {
    InputDecoration toReturn = decorationBuilder?.call(fieldState) ?? InputDecoration();
    toReturn = toReturn.merge(
      secondary: InputDecoration(
        prefixIcon: Icon(Icons.calendar_today),
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
