import 'package:flutter/material.dart';

abstract class FooFieldController<T> extends ChangeNotifier {
  

  FooFieldController({
    required bool enabled,
  }): _enabled = enabled;

  bool _enabled;

  bool get enabled => _enabled;

  set enabled(bool value) {
    _enabled = value;
    notifyListeners();
  }

  bool validate();

  void clear();

  void save();
  
}