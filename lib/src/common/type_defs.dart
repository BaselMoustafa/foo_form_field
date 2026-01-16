import 'package:flutter/material.dart';

import '../../foo_form_field.dart';

typedef FooFormFieldBuilder<FieldValue> = Widget Function(
  BuildContext context, 
  FooFormFieldState<FieldValue> fieldState
);

typedef FooFormFieldStateProvider<FieldValue> = void Function(
  FooFormFieldState<FieldValue> fieldState
);

typedef RangeFormFieldBuilder<Value extends Comparable> = Widget Function(
  BuildContext context, 
  Widget minField, 
  Widget maxField, 
  FooFormFieldState<Range<Value>> fieldState
);

typedef DecorationBuilder<T> = InputDecoration Function(FooFormFieldState<T> fieldState);