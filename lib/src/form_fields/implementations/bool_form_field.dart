
// import 'package:flutter/material.dart';

// import '../../../core/widgets/field_with_error_text_widget.dart';
// import '../../../core/widgets/selection_card.dart';
// import '../../base/value_form_field/value_field_controller.dart';
// import '../../base/value_form_field/value_form_field.dart';

// class BooleanFormField extends StatelessWidget {
//   const BooleanFormField({
//     super.key,
//     required this.controller,
//     this.yesText = "Yes",
//     this.noText = "No",
//     this.onSaved,
//     this.validator,
//     this.autovalidateMode,
//     this.errorBuilder,
//     this.forceErrorText,
//     this.restorationId,
//     this.onChanged,
//     this.builder,
//   });

//   /// Text displayed for the affirmative option.
//   final String yesText;

//   /// Text displayed for the negative option.
//   final String noText;

//   /// Controller supplying the boolean value and state.
//   final ValueFieldController<bool> controller;

//   /// Optional custom builder replacing the default button layout.
//   final Widget Function(BuildContext context)? builder;

//   final void Function(bool? value)? onSaved;
//   final String? Function(bool? value)? validator;
//   final AutovalidateMode? autovalidateMode;
//   final FormFieldErrorBuilder? errorBuilder;
//   final String? forceErrorText;
//   final String? restorationId;
//   final void Function(bool? value)? onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return ValueFormField<bool>(
//       controller: controller,
//       builder: _fieldBuilder,
//       onSaved: onSaved,
//       validator: validator,
//       autovalidateMode: autovalidateMode,
//       errorBuilder: errorBuilder,
//       restorationId: restorationId,
//       onChanged: onChanged,
//     );
//   }

//   /// Builds the default toggle presentation using the controller value.
//   Widget _fieldBuilder(BuildContext context, bool? value) {
//     if (builder != null) {
//       return builder!(context);
//     }

//     return FieldWithErrorTextWidget(
//       errorText: controller.errorText,
//       fieldWidget: Row(
//         spacing: 6,
//         children: [
//           _ActionButton(parentWidget: this, isYesButton: true),

//           _ActionButton(parentWidget: this, isYesButton: false),
//         ],
//       ),
//     );
//   }
// }

// /// Single option button toggling the boolean controller value.
// class _ActionButton extends StatelessWidget {
//   const _ActionButton({required this.parentWidget, required this.isYesButton});

//   final bool isYesButton;
//   final BooleanFormField parentWidget;

//   ValueFieldController<bool> get _controller => parentWidget.controller;

//   @override
//   Widget build(BuildContext context) {
//     return SelectionCard(
//       enabled: _controller.enabled,
//       onTap: _onTap,
//       isSelected: _controller.value == isYesButton,
//       child: Text(isYesButton ? parentWidget.yesText : parentWidget.noText),
//     );
//   }

//   /// Toggles the controller value and notifies the parent callback.
//   void _onTap() {
//     if (_controller.value == isYesButton) {
//       _controller.value = null;
//     } else {
//       _controller.value = isYesButton;
//     }
//     parentWidget.onChanged?.call(_controller.value);
//   }
// }
