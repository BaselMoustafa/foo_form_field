import 'package:flutter/widgets.dart';

class FlutterFieldController<T> extends ChangeNotifier {
  
  T? get value => _formFieldState.value;

  late final FormFieldState<T> _formFieldState;

  void setFormFieldState(FormFieldState<T> formFieldState){
    this._formFieldState = formFieldState;
  }

  set value(T? value) {
    _formFieldState.didChange(value);
    notifyListeners();
  }
  
  void clear(){
    _formFieldState.didChange(null);
    notifyListeners();
  }

  void validate(){
    _formFieldState.validate();
    notifyListeners();
  }
  
}