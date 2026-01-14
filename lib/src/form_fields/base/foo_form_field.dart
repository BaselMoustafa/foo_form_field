
import 'package:flutter/material.dart';
import '../../../foo_form_field.dart';
import '../../common/models/foo_form_field_state.dart';
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

  final Widget Function(BuildContext context, FooFormFieldState<FieldValue> fieldState) builder;


  final FooFormFieldProperties<Value>? properties;
  

  @override
  State<FooFormField<Value, FieldValue>> createState() => _FooFormFieldState<Value, FieldValue>();
}

class _FooFormFieldState<Value, FieldValue> extends State<FooFormField<Value, FieldValue>> {
  
  late FormFieldState<FieldValue> _fieldState;

  @override
  void initState() {
    super.initState();
    if (widget.controller is ConvertableRangeFieldController) {
      (widget.controller as ConvertableRangeFieldController).invokeSyncers();
    }

    WidgetsBinding.instance.addPostFrameCallback(
      _afterFirstBuild,
    );
  }

  void _afterFirstBuild(Duration timeStamp) {
    _onControllerValueChanged();
    _addListenerToCurrentController();
  }

  @override
  void didUpdateWidget(covariant FooFormField<Value, FieldValue> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onControllerValueChanged);
      _addListenerToCurrentController();
    }
  }
  @override
  void dispose() {
    widget.controller.removeListener(_onControllerValueChanged);
    super.dispose();
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

  void _onControllerValueChanged() {
    _fieldState.didChange(
      widget.controller.fieldValue,
    );
  }

  void _addListenerToCurrentController() {
    _fieldState.didChange(widget.controller.fieldValue);
    widget.controller.addListener(
      _onControllerValueChanged,
    );
  }
  
}
