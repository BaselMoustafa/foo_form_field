// part of '../exporter.dart';

// /// Range form field that maps integer values to string-backed inputs.
// class IntStringRangeFormField extends StatelessWidget {
//   const IntStringRangeFormField({
//     super.key,
//     required this.controller,
//     this.minFieldBuilder,
//     this.maxFieldBuilder,
//     this.rangeValidator,
//     this.layoutBuilder,
//     this.onSaved,
//     this.validator,
//     this.autovalidateMode,
//     this.restorationId,
//     this.onChanged,
//   });

//   /// Validator applied to ensure min/max relationships.
//   final RangeValidator<int>? rangeValidator;

//   /// Shared controller orchestrating the bound controllers.
//   final IntStringRangeFieldController controller;

//   /// Builder for the minimum bound field; defaults to `IntStringFormField`.
//   final Widget Function(BuildContext context, String? value)? minFieldBuilder;

//   /// Builder for the maximum bound field; defaults to `IntStringFormField`.
//   final Widget Function(BuildContext context, String? value)? maxFieldBuilder;
//   final Widget Function(BuildContext context, Widget minField, Widget maxField)?
//   layoutBuilder;
//   final void Function(Range<int?>? value)? onSaved;
//   final String? Function(Range<int?>? value)? validator;
//   final AutovalidateMode? autovalidateMode;
//   final String? restorationId;
//   final void Function(Range<int?>? value)? onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return ConvertableRangeFormField(
//       controller: controller,
//       layoutBuilder: layoutBuilder,
//       onSaved: onSaved,
//       validator: validator,
//       autovalidateMode: autovalidateMode,
//       restorationId: restorationId,
//       onChanged: onChanged,
//       rangeValidator:
//           rangeValidator ??
//           RangeValidator<int>(
//             firstIsBiggerThanSecond: (int first, int second) => first > second,
//           ),
//       minFieldBuilder: _minFieldBuilder,
//       maxFieldBuilder: _maxFieldBuilder,
//     );
//   }

//   /// Standard builder falling back to a numeric form field for the minimum bound.
//   Widget _minFieldBuilder(BuildContext context, String? value) {
//     if (minFieldBuilder != null) {
//       return minFieldBuilder!(context, value);
//     }
//     return IntStringFormField(controller: controller.minValueController);
//   }

//   /// Standard builder falling back to a numeric form field for the maximum bound.
//   Widget _maxFieldBuilder(BuildContext context, String? value) {
//     if (maxFieldBuilder != null) {
//       return maxFieldBuilder!(context, value);
//     }
//     return IntStringFormField(controller: controller.maxValueController);
//   }
// }
