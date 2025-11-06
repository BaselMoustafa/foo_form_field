import 'package:flutter/material.dart';
///[I] is The type which the form field accepts
///[O] is The type which the client wants to get or set
abstract class FooFieldController<O,I> extends ChangeNotifier {
  
  final O? initialValue;

  I? get initialValueAsFieldValue => toFieldValue(initialValue);
  
  bool _enabled;

  final O? Function(I? i) fromFieldValue;
  
  final I? Function(O? o) toFieldValue;

  FooFieldController({
    required bool? enabled,
    required this.initialValue,
    required this.fromFieldValue,
    required this.toFieldValue,
  }): _enabled = enabled?? true;

  bool get enabled => _enabled;

  set enabled(bool value) {
    _enabled = value;
    notifyListeners();
  }

  O? get value;

  set value(O? value);

  bool validate();

  void clear();

  void save();
  
}