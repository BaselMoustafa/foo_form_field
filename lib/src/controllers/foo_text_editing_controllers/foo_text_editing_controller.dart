import 'package:flutter/widgets.dart';

import '../../../foo_form_field.dart';

abstract class FooTextEditingController<Value> extends FooFieldController<Value> {

  bool _isInitialized = false;
  late final TextEditingController? textEditingController;

  FooTextEditingController({
    required super.initialValue,
    required super.areEqual,
  });
  
  
  String? toText(Value? value);

  Value? fromText(String? text);

  void init() {
    if (_isInitialized) {
      return;
    }
    _isInitialized = true;
    textEditingController= TextEditingController(
      text: toText(initialValue),
    );
    _invokeSyncers();
  }

  void _invokeSyncers(){
    addListener(_onValueChanged);
    textEditingController?.addListener(_onTextEditingControllerChanged);
  }

  void _removeSyncers() {
    removeListener(_onValueChanged);
    textEditingController?.removeListener(_onTextEditingControllerChanged);
  }

  @override
  void dispose() {
    _removeSyncers();
    textEditingController?.dispose();
    super.dispose();
  }

  void _onTextEditingControllerChanged() {
    if (value==null && textEditingController!.text=="") {
      return ;
    }
    value = fromText(textEditingController!.text);
  }

  void _onValueChanged() {
    textEditingController?.text = toText(value) ?? '';
  }

}

class FooRangeTextEditingController<
  Value extends Comparable,
  BoundryController extends FooTextEditingController<Value>
> extends RangeFieldController<Value, BoundryController> {

  FooRangeTextEditingController({
    required super.minController,
    required super.maxController,
  });
}
