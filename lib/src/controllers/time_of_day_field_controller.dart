import 'package:flutter/material.dart';
import '../../foo_form_field.dart';
import '../common/extentions/comparable_extension.dart';

class TimeOfDayFieldController extends ValueFieldController<TimeOfDay> {
  
  TimeOfDayFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }):super(
    areEqual: (TimeOfDay x, TimeOfDay y) => x.isEqualTo(y),
  );
}

class TimeOfDayRangeFieldController extends RangeFieldController<TimeOfDay,TimeOfDayFieldController> {
  TimeOfDayRangeFieldController({
    required super.minController,
    required super.maxController,
    super.enabled,
    super.forcedErrorText,
  });
}

