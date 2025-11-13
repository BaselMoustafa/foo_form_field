part of '../exporter.dart';

/// Form field for picking a single date with optional custom rendering and formatter.
class DateTimeFormField extends StatelessWidget {
  const DateTimeFormField({
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

  /// Controller managing the selected date.
  final ValueFieldController<DateTime> controller;

  /// Formats the current date when using the default builder.
  final String? Function(DateTime? date)? dateFormatter;

  /// Custom widget builder overriding the decorated default.
  final Widget Function(BuildContext context, DateTime? value)? builder;

  /// Optional tap handler; when omitted a date picker is presented.
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
      builder:
          builder ??
          (BuildContext context, DateTime? value) {
            final value = controller.value;
            return FittedBox(
              alignment: AlignmentDirectional.centerStart,
              fit: BoxFit.scaleDown,
              child: Text(
                dateFormatter?.call(value) ??
                    "${value?.year}-${value?.month}-${value?.day}",
                textAlign: TextAlign.start,
              ),
            );
          },
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
      initialDate: controller.value ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
    );

    if (selectedDate != null) {
      controller.value = selectedDate;
    }
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
  final FooFieldController<DateTime, DateTime> controller;

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
