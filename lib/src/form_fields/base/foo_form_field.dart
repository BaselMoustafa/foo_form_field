import 'package:flutter/material.dart';
import 'package:foo_form_field/src/core/controllers/foo_field_controller.dart';

class FooFormField<T> extends StatefulWidget {

  const FooFormField({
    super.key,
    required this.builder,
    this.controller,
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.errorBuilder,
    this.forceErrorText,
    this.restorationId,
    this.onChanged,
  });

  final FooFieldController<T>? controller;
  final Widget Function(BuildContext context, T? value , String? errorText) builder;
  final void Function(T? value)? onSaved;
  final String? Function(T? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final FormFieldErrorBuilder? errorBuilder;
  final String? forceErrorText;
  final String? restorationId;
  final void Function(T? value)? onChanged;

  @override
  State<FooFormField<T>> createState() => _FooFormFieldState<T>();
}

class _FooFormFieldState<T> extends State<FooFormField<T>> {
  late final FooFieldController<T> controller ;
  late bool _controllerLocallyInitialized = false;

  late final GlobalKey<FormFieldState<T>> _formFieldKey;

  @override
  void initState() {
    super.initState();
    _formFieldKey = GlobalKey<FormFieldState<T>>();
    _initializeController();
  }

  @override
  void dispose() {
    controller.removeListener(_notifyChangeInValue);
    if(_controllerLocallyInitialized){
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeController(){
    if(widget.controller != null){
      controller = widget.controller!;
    } else {
      controller = FooFieldController<T>();
      _controllerLocallyInitialized = true;
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.setFormFieldState(_formFieldKey.currentState!);
      controller.addListener(_notifyChangeInValue);
    });
  }

  void _notifyChangeInValue(){
    widget.onChanged?.call(controller.value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      key: _formFieldKey,
      builder: (field) => widget.builder(context, field.value, field.errorText),
      onSaved: widget.onSaved,
      validator: widget.validator,
      errorBuilder: widget.errorBuilder,
      initialValue: controller.value,
      enabled: controller.enabled,
      autovalidateMode: widget.autovalidateMode,
      restorationId: widget.restorationId,
      forceErrorText: widget.forceErrorText,
    );
  }
}