import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class FooFormField<O,I> extends StatefulWidget {

  const FooFormField({
    super.key,
    required this.controller,
    required this.builder,
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.errorBuilder,
    this.restorationId,
    this.onChanged,
  });

  final FooFieldController<O,I> controller;
  final Widget Function(BuildContext context , I? value) builder;
  final void Function(O? value)? onSaved;
  final String? Function(O? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final FormFieldErrorBuilder? errorBuilder;
  final String? restorationId;
  final void Function(O? value)? onChanged;

  @override
  State<FooFormField<O,I>> createState() => _FooFormFieldState<O,I>();
}

class _FooFormFieldState<O,I> extends State<FooFormField<O,I>> {

  late final GlobalKey<FormFieldState<I>> _formFieldKey;

  @override
  void initState() {
    super.initState();
    _formFieldKey = GlobalKey<FormFieldState<I>>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.setFormFieldState(_formFieldKey.currentState!);
      widget.controller.addListener(_onEvent);
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onEvent);
    super.dispose();
  }

  void _onEvent(){
    setState(() {});
    if(widget.controller.isValueChanged) {
      widget.onChanged?.call(widget.controller.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<I>(  
      key: _formFieldKey,
      onSaved: (I? inputValue) => widget.onSaved?.call(
        widget.controller.mapper.toClientType(inputValue),
      ),
      validator: (I? inputValue) => widget.validator?.call(
        widget.controller.mapper.toClientType(inputValue),
      ),
      errorBuilder: widget.errorBuilder,
      initialValue: widget.controller.initialValueAsFieldValue,
      enabled: widget.controller.enabled,
      autovalidateMode: widget.autovalidateMode,
      restorationId: widget.restorationId,
      forceErrorText: widget.controller.forcedErrorText,
      builder: (FormFieldState<I> fieldState) {
        return widget.builder(context,fieldState.value);
      },
    );
  }
}