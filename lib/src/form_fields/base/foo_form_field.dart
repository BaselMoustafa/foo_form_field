import 'package:flutter/material.dart';
import '../../../foo_form_field.dart';

typedef FooFormFieldBuilder<FieldValue> = Widget Function(BuildContext context, FooFormFieldState<FieldValue> fieldState);
typedef FooFormFieldStateProvider<FieldValue> = void Function(FooFormFieldState<FieldValue> fieldState);

class FooFormField<Value> extends StatefulWidget {
  const FooFormField({
    super.key,
    required this.controller,
    required this.builder,
    this.properties,
    this.stateProvider,
  });

  final FooFieldController<Value> controller;

  final FooFormFieldBuilder<Value> builder;

  final FooFormFieldProperties<Value>? properties;

  final FooFormFieldStateProvider<Value>? stateProvider;
  
  @override
  State<FooFormField<Value>> createState() => _FooFormFieldState<Value>();
}

class _FooFormFieldState<Value> extends State<FooFormField<Value>> {
  
  late FormFieldState<Value> _fieldState;

  FooFieldController<Value> get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_)=>_afterFirstBuild(),
    );
  }

  void _afterFirstBuild() {
    widget.stateProvider?.call(
      FooFormFieldState(
        fieldState: _fieldState,
      ),
    );
    _addListenerToCurrentController();
  }

  @override
  void didUpdateWidget(covariant FooFormField<Value> oldWidget) {
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
    return FormField<Value>(
      onSaved: widget.properties?.onSaved,
      validator: widget.properties?.validator,
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
    if (controller is RangeFieldController) {
      (controller as RangeFieldController).invokeSyncers();
    }
    _fieldState.didChange(
      controller.value,
    );
    controller.addListener(
      _onControllerValueChanged,
    );
  }

  void _onControllerValueChanged() {
    _fieldState.didChange(
      controller.value,
    );
    widget.properties?.onChanged?.call(
      controller.value,
    );
  }
  
}
