
import 'package:flutter/material.dart';
import '../../../foo_form_field.dart';
import '../../common/models/controlled_field_state.dart';
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

  final Widget Function(BuildContext context, ControlledFieldState<Value,FieldValue> controlledFieldState) builder;


  final FooFormFieldProperties<Value>? properties;
  

  @override
  State<FooFormField<Value, FieldValue>> createState() => _FooFormFieldState<Value, FieldValue>();
}

class _FooFormFieldState<Value, FieldValue> extends State<FooFormField<Value, FieldValue>> {
  
  bool _firstBuild = true;

  late final ControlledFieldState<Value,FieldValue> _controlledFieldState;

  @override
  void initState() {
    super.initState();
    if (widget.controller is ConvertableRangeFieldController) {
      (widget.controller as ConvertableRangeFieldController).invokeSyncers();
    }
  }

  @override
  void dispose() {
    _controlledFieldState.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FooFormField<Value, FieldValue> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_controlledFieldState.controller != widget.controller) {
      _controlledFieldState.changeController(widget.controller);  
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<FieldValue>(
      onSaved: (FieldValue? fieldValue) => widget.properties?.onSaved?.call(
        widget.controller.mapper.toValue(fieldValue),
      ),
      validator: (FieldValue? fieldValue) => widget.properties?.validator?.call(
        widget.controller.mapper.toValue(fieldValue),
      ),
      errorBuilder: widget.properties?.errorBuilder,
      enabled: widget.controller.enabled,
      autovalidateMode: widget.properties?.autovalidateMode,
      restorationId: widget.properties?.restorationId,
      forceErrorText: widget.properties?.forceErrorText,
      builder: (formFieldState) {
        if (_firstBuild) {
          _firstBuild = false;
          _controlledFieldState = ControlledFieldState<Value,FieldValue>(
            controller: widget.controller,
            onChanged: widget.properties?.onChanged,
          );
          _controlledFieldState.setFieldState(formFieldState);
        }
        return widget.builder(context, _controlledFieldState);
      },
    );
  }
}
