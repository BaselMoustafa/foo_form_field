import 'package:flutter/material.dart';
import 'package:foo_form_field/src/core/controllers/value_field_controller.dart';

class ValueFormField<T> extends StatefulWidget {

  const ValueFormField({
    super.key,
    required this.controller,
    required this.builder,
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.errorBuilder,
    this.forceErrorText,
    this.restorationId,
    this.onChanged,
  });

  final ValueFieldController<T> controller;
  final Widget Function(BuildContext context,String? errorText) builder;
  
  final void Function(T? value)? onSaved;
  final String? Function(T? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final FormFieldErrorBuilder? errorBuilder;
  final String? forceErrorText;
  final String? restorationId;
  final void Function(T? value)? onChanged;

  @override
  State<ValueFormField<T>> createState() => _ValueFormFieldState<T>();
}

class _ValueFormFieldState<T> extends State<ValueFormField<T>> {

  late final GlobalKey<FormFieldState<T>> _formFieldKey;

  @override
  void initState() {
    super.initState();
    _formFieldKey = GlobalKey<FormFieldState<T>>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.setFormFieldState(_formFieldKey.currentState!);
      widget.controller.addListener(_notifyChangeInValue);
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_notifyChangeInValue);
    super.dispose();
  }

  void _notifyChangeInValue(){
    setState(() {});
    widget.onChanged?.call(widget.controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      key: _formFieldKey,
      builder: (FormFieldState<T> field) => widget.builder(context,field.errorText),
      onSaved: widget.onSaved,
      validator: widget.validator,
      errorBuilder: widget.errorBuilder,
      initialValue: widget.controller.value,
      enabled: widget.controller.enabled,
      autovalidateMode: widget.autovalidateMode,
      restorationId: widget.restorationId,
      forceErrorText: widget.forceErrorText,
    );
  }
}