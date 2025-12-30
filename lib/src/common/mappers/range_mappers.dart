

import '../../../foo_form_field.dart';
import '../ranges/ranges.dart';

class IntRangeToStringRangeMapper extends Mapper<Range<int>, Range<String>> {

  IntRangeToStringRangeMapper():super(
    toValue: (Range<String>? range){
      if(range == null){
        return null;
      }
      return Range<int>(
        min: int.tryParse(range.min ?? ''),
        max: int.tryParse(range.max ?? ''),
        areEqual: (int x, int y) => x == y,
      );
    },
    toFieldValue: (Range<int>? range){
      if(range == null){
        return null;
      }
      return Range<String>(
        min: range.min?.toString(),
        max: range.max?.toString(),
        areEqual: (String x, String y) => x == y,
      );
    },
  );
}