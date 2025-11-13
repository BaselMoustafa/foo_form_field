import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../foo_form_field.dart';
import '../core/extentions/foo_text_input_formatter_list_extension.dart';
import '../core/widgets/field_with_error_text_widget.dart';
import '../core/widgets/selection_card.dart';

/// Aggregates all form field base classes and ready-to-use implementations.
part 'base/convertable_range_form_field.dart';
part 'base/decorated_value_form_field.dart';
part 'base/foo_form_field.dart';
part 'base/foo_string_form_field.dart';
part 'base/range_form_field.dart';
part 'base/value_form_field.dart';

part 'implementations/boolean_form_field.dart';
part 'implementations/date_time_form_field.dart';
part 'implementations/date_time_range_form_field.dart';
part 'implementations/int_string_form_field.dart';
part 'implementations/int_string_range_form_field.dart';
part 'implementations/string_form_field.dart';
