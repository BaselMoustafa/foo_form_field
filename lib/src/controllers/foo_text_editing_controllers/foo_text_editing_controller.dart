import 'package:flutter/widgets.dart';

import '../../../foo_form_field.dart';

class FooTextEditingController<Value> extends FooFieldController<Value, String> {

  final TextEditingController textEditingController;
  FooTextEditingController({
    required super.initialValue,
    required super.enabled,
    required super.mapper,
  }) : textEditingController = TextEditingController(
    text: mapper.toFieldValue(initialValue),
  ),
    super(
      areEqual: (Value x, Value y){
        String? xString = mapper.toFieldValue(x);
        String? yString = mapper.toFieldValue(y);
        return xString == yString;
      },
    );

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}

class FooRangeTextEditingController<
  Value extends Comparable,
  BoundryController extends FooTextEditingController<Value>
> extends ConvertableRangeFieldController<Value, String,BoundryController> {

  FooRangeTextEditingController({
    required super.minController,
    required super.maxController,
    required super.mapper,
    super.enabled,
  });
}
