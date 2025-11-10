import 'package:foo_form_field/src/core/ranges/range.dart';

class FieldValueMapper<O,I> {
  final O? Function(I? i) toClientType;
  final I? Function(O? o) toFieldType;

  FieldValueMapper({
    required this.toClientType,
    required this.toFieldType,
  });

  FieldValueMapper<Range<O>,Range<I>> toRangeMapper({
    required bool Function(O x, O y) areEqualOutputs,
  }){
    return FieldValueMapper<Range<O>,Range<I>>(
      toClientType: (Range<I>? inputRange){
        if (inputRange == null) {
          return null;
        }
        return Range<O>(
          min: toClientType(inputRange.min),
          max: toClientType(inputRange.max),
          areEqual: areEqualOutputs,
        );
      },
      toFieldType: (Range<O>? outputRange){
        if (outputRange == null) {
          return null;
        }
        return Range<I>(
          min: toFieldType(outputRange.min),
          max: toFieldType(outputRange.max),
          areEqual:(I x, I y){
            final firstValue = toClientType(x);
            final secondValue = toClientType(y);
            if (firstValue == null && secondValue == null) {
              return true;
            }
            if (firstValue == null && secondValue != null) {
              return false;
            }
            if (firstValue != null && secondValue == null) {
              return false;
            }
            return areEqualOutputs(firstValue!, secondValue!);
          },
        );
      },
    );
  }

}