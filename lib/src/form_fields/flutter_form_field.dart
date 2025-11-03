import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_fields/src/core/controllers/flutter_field_controller.dart';
import 'package:flutter_form_fields/src/form_fields/base_flutter_form_field.dart';

class FlutterFormField<T> extends FormField<T> implements BaseFlutterFormField<T> {

  @override
  final FlutterFieldController<T>? controller;

  const FlutterFormField({
    super.key,
    this.controller,
    required super.builder,
    super.onSaved,
    super.forceErrorText,
    super.validator,
    super.errorBuilder,
    super.initialValue,
    super.enabled = true,
    super.autovalidateMode,
    super.restorationId,
  });

  @override
  FormFieldState<T> createState() => _FlutterFormFieldState<T>();
}

class _FlutterFormFieldState<T> extends FormFieldState<T> {
  
  @override
  FlutterFormField<T> get widget => super.widget as FlutterFormField<T>;

  @override
  void initState() {
    super.initState();
    widget.controller?.setFormFieldState(this);
  }
}

