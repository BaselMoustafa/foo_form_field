import 'package:foo_form_field/foo_form_field.dart';

class DateFieldController extends ValueFieldController<DateTime> {
  DateFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    bool Function(DateTime x, DateTime y)? areEqual,
  }):super(
    areEqual: areEqual?? (DateTime x, DateTime y) => x.year == y.year && x.month == y.month && x.day == y.day,
  );
}