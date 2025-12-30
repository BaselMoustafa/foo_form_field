
import 'package:flutter/material.dart';

import '../../common/models/foo_form_field_properties.dart';
import '../../controllers/base/foo_field_controller.dart';

class FooFormField<Value, FieldValue> extends StatefulWidget {
  const FooFormField({
    super.key,
    required this.controller,
    required this.builder,
    this.properties,
  });

  final FooFieldController<Value, FieldValue> controller;

  final Widget Function(BuildContext context, FieldValue? value) builder;


  final FooFormFieldProperties<Value>? properties;
  

  @override
  State<FooFormField<Value, FieldValue>> createState() => _FooFormFieldState<Value, FieldValue>();
}

class _FooFormFieldState<O, I> extends State<FooFormField<O, I>> {

  late final GlobalKey<FormFieldState<I>> _formFieldKey;

  O? _latestValue;

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

  void _onEvent() {
    setState(() {});
    if (_shouldNotifyUser) {
      widget.properties?.onChanged?.call(widget.controller.value);
      _latestValue = widget.controller.value;
    }
  }

  bool get _shouldNotifyUser {
    final value = widget.controller.value;
    if(value == null && _latestValue == null){
      return false;
    }
    if(value == null && _latestValue != null){
      return true;
    }
    if(value != null && _latestValue == null){
      return true;
    }
    return ! widget.controller.areEqual(
      value as O, 
      _latestValue as O,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<I>(
      key: _formFieldKey,
      onSaved: (I? inputValue) => widget.properties?.onSaved?.call(
        widget.controller.mapper.toValue(inputValue),
      ),
      validator: (I? inputValue) => widget.properties?.validator?.call(
        widget.controller.mapper.toValue(inputValue),
      ),
      errorBuilder: widget.properties?.errorBuilder,
      initialValue: widget.controller.initialValueAsFieldValue,
      enabled: widget.controller.enabled,
      autovalidateMode: widget.properties?.autovalidateMode,
      restorationId: widget.properties?.restorationId,
      forceErrorText: widget.controller.forcedErrorText,
      builder: (FormFieldState<I> fieldState) {
        return widget.builder(context, fieldState.value);
      },
    );
  }
}
