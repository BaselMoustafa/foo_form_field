
import 'package:flutter/material.dart';
import '../../../foo_form_field.dart';

typedef FooFormFieldBuilder<FieldValue> = Widget Function(BuildContext context, FooFormFieldState<FieldValue> fieldState);

class FooFormField<Value, FieldValue> extends StatefulWidget {
  const FooFormField({
    super.key,
    required this.controller,
    required this.builder,
    this.properties,
  });

  final FooFieldController<Value, FieldValue> controller;

  final FooFormFieldBuilder<FieldValue> builder;

  final FooFormFieldProperties<Value>? properties;
  
  @override
  State<FooFormField<Value, FieldValue>> createState() => _FooFormFieldState<Value, FieldValue>();
}

class _FooFormFieldState<Value, FieldValue> extends State<FooFormField<Value, FieldValue>> {
  
  late FormFieldState<FieldValue> _fieldState;

  FooFieldController<Value, FieldValue> get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    if (controller is ConvertableRangeFieldController) {
      (controller as ConvertableRangeFieldController).invokeSyncers();
    }

    WidgetsBinding.instance.addPostFrameCallback(
      (_)=>_addListenerToCurrentController(),
    );
  }

  @override
  void didUpdateWidget(covariant FooFormField<Value, FieldValue> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != controller) {
      oldWidget.controller.removeListener(_onControllerValueChanged);
      _addListenerToCurrentController();
    }
  }
  @override
  void dispose() {
    controller.removeListener(_onControllerValueChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<FieldValue>(
      onSaved: (FieldValue? fieldValue) => widget.properties?.onSaved?.call(
        controller.mapper.toValue(fieldValue),
      ),
      validator: (FieldValue? fieldValue) => widget.properties?.validator?.call(
        controller.mapper.toValue(fieldValue),
      ),
      errorBuilder: widget.properties?.errorBuilder,
      autovalidateMode: widget.properties?.autovalidateMode,
      restorationId: widget.properties?.restorationId,
      forceErrorText: widget.properties?.forceErrorText,
      builder: (formFieldState) {
        _fieldState = formFieldState;
        return widget.builder(
          context, 
          FooFormFieldState(
            fieldState: _fieldState,
          ),
        );
      },
    );
  }

  void _addListenerToCurrentController() {
    _fieldState.didChange(
      controller.fieldValue
    );
    controller.addListener(
      _onControllerValueChanged,
    );
  }

  void _onControllerValueChanged() {
    _fieldState.didChange(
      controller.fieldValue,
    );
    widget.properties?.onChanged?.call(
      controller.value,
    );
  }
  
}
