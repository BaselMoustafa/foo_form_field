import 'package:flutter/material.dart';
import 'package:foo_form_field/src/core/controllers/value_field_controller.dart';
import 'package:foo_form_field/src/core/widgets/field_with_error_text_widget.dart';
import 'package:foo_form_field/src/core/widgets/selection_card.dart';
import 'package:foo_form_field/src/form_fields/base/foo_form_field.dart';

class BooleanFormField extends StatelessWidget {
  const BooleanFormField({
    super.key,
    required this.controller,
    this.yesText = "Yes",
    this.noText = "No",
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.errorBuilder,
    this.forceErrorText,
    this.restorationId,
    this.onChanged,
    this.builder,
  });

  final String yesText;
  final String noText;

  final ValueFieldController<bool> controller;
  final Widget Function(BuildContext context, String? errorText)? builder;
  final void Function(bool? value)? onSaved;
  final String? Function(bool? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final FormFieldErrorBuilder? errorBuilder;
  final String? forceErrorText;
  final String? restorationId;
  final void Function(bool? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return FooFormField<bool>(
      controller: controller,
      onSaved: onSaved,
      validator: validator,
      autovalidateMode: autovalidateMode,
      errorBuilder: errorBuilder,
      forceErrorText: forceErrorText,
      restorationId: restorationId,
      onChanged: onChanged,
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, String? errorText){
    return FieldWithErrorTextWidget(
      errorText: errorText,
      fieldWidget: builder!=null? builder!(context,errorText): Row(
        spacing: 6,
        children: [
          _ActionButton(
            parentWidget: this, 
            isYesButton: true,
          ),
      
          _ActionButton(
            parentWidget: this, 
            isYesButton: false,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.parentWidget,
    required this.isYesButton,
  });

  final bool isYesButton;
  final BooleanFormField parentWidget;

  ValueFieldController<bool> get _controller => parentWidget.controller;

  @override
  Widget build(BuildContext context) {
    return SelectionCard(
      enabled: _controller.enabled,
      onTap: _onTap, 
      isSelected: _controller.value == isYesButton, 
      child: Text(
        isYesButton ? parentWidget.yesText : parentWidget.noText
      ),
    );
  }

  void _onTap() {
    if(_controller.value == isYesButton){
      _controller.value = null;
    } else {
      _controller.value = isYesButton;
    }
    parentWidget.onChanged?.call(_controller.value);
  }
}
