import 'package:flutter/material.dart';
import '../../foo_form_field.dart';
import '../common/extentions/comparable_extension.dart';

class TimeOfDayFieldController extends FooFieldController<TimeOfDay> {
  
  TimeOfDayFieldController({
    super.initialValue,
  }):super(
    areEqual: (TimeOfDay x, TimeOfDay y) => x.isEqualTo(y),
  );
}

class TimeOfDayRangeFieldController extends RangeFieldController<TimeOfDay,TimeOfDayFieldController> {
  TimeOfDayRangeFieldController({
    TimeOfDay? initialMin,
    TimeOfDay? initialMax,
  }):super(
    minController: TimeOfDayFieldController(
      initialValue: initialMin,
    ),
    maxController: TimeOfDayFieldController(
      initialValue: initialMax,
    ),
  );
}

