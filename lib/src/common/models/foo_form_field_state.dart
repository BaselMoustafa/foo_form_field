import 'package:flutter/material.dart';

class FooFormFieldState<FieldValue>{
  
  late final FormFieldState<FieldValue> _fieldState;
  
  FooFormFieldState({
    required FormFieldState<FieldValue> fieldState,
  }) : _fieldState = fieldState;

  final bool enabled = true;


  String? get errorText => _fieldState.errorText;

  bool get hasError => _fieldState.hasError;
  
  bool get hasIntrinsicWidth => _fieldState.hasInteractedByUser;
  
  bool get isValid => _fieldState.isValid;
  
  String? get restorationId => _fieldState.restorationId;
  
  RestorationBucket? get bucket => _fieldState.bucket;
  
  bool get restorePending => _fieldState.restorePending;
  
  void save() => _fieldState.save();
  
  void validate() => _fieldState.validate();
  
  FormField<FieldValue> get widget => _fieldState.widget;
  
  FieldValue? get value => _fieldState.value;
  
  BuildContext get context => _fieldState.context;

  @override
  int get hashCode => _fieldState.hashCode;
  
  @override
  bool operator ==(Object other) {
    if (other is FooFormFieldState<FieldValue>) {
      return _fieldState == other._fieldState;
    }
    return super == other;
  }
}