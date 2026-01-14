import 'package:flutter/material.dart';

import '../../../foo_form_field.dart';

class ControlledFieldState<
  Value, 
  FieldValue
>{
  
  late final FormFieldState<FieldValue> _fieldState;
  final void Function(Value? value)? _onChanged;
  
  FooFieldController<Value, FieldValue> _controller;

  FooFieldController<Value, FieldValue> get controller => _controller;

  ControlledFieldState({
    required FooFieldController<Value, FieldValue> controller,
    void Function(Value? value)? onChanged,
  }) : _controller = controller,
       _onChanged = onChanged;

  void setFieldState(FormFieldState<FieldValue> fieldState) {
    _fieldState = fieldState;
    changeController(_controller);
  }

  void changeController(FooFieldController<Value, FieldValue> newController) {
    _controller.removeListener(_controllerListener);
    _controller = newController;
    _controller.addListener(_controllerListener);
  }

  void _controllerListener() {
    final previousValue = _controller.mapper.toValue(_fieldState.value);
    final newValue = _controller.value;
    _fieldState.didChange(_controller.fieldValue);

    shouldNotify(){
      if(previousValue == null && newValue == null){
        return false;
      }
      if(previousValue == null && newValue != null){
        return true;
      }
      if(previousValue != null && newValue == null){
        return true;
      }
      return ! _controller.areEqual(
        previousValue as Value, newValue as Value,
      );
    }
    if (shouldNotify()) {
      _onChanged?.call(newValue);
    }
  }

  void dispose() {
    _controller.removeListener(_controllerListener);
  }

  void save() => _fieldState.save();

  void validate() => _fieldState.validate();

  String? get errorText => _fieldState.errorText;

  bool get hasError => _fieldState.hasError;

  bool get isValid => _fieldState.isValid;
  
  bool get restorePending => _fieldState.restorePending;

  RestorationBucket? get bucket => _fieldState.bucket;

  Value? get value => _controller.value;
  
  FieldValue? get fieldValue => _controller.fieldValue;

}