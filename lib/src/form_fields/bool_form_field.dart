
import 'package:flutter/material.dart';
import '../../foo_form_field.dart';
import '../common/widgets/field_with_error_text_widget.dart';
import '../common/widgets/selection_card.dart';

class BooleanFormField extends StatelessWidget {
 
  const BooleanFormField({
    super.key,
    required this.controller,
    this.yesText="Yes",
    this.noText="No",
    this.textStyle,
    this.builder,
    this.properties,
    this.stateProvider,
  }); 

  final BoolFieldController controller;

  final String yesText;

  final String noText;

  final TextStyle? textStyle;

  final FooFormFieldBuilder<bool>? builder;

  final FooFormFieldProperties<bool>? properties;
  
  final FooFormFieldStateProvider<bool>? stateProvider;

  @override
  Widget build(BuildContext context) {
    return FooFormField(
      controller: controller,
      builder: _fieldBuilder,
      properties: properties,
      stateProvider: stateProvider,
    );
  }

  /// Builds the default toggle presentation using the controller value.
  Widget _fieldBuilder(BuildContext context, FooFormFieldState<bool> fieldState) {
    if (builder != null) {
      return builder!(context, fieldState);
    }

    return FieldWithErrorTextWidget(
      errorText: fieldState.errorText,
      fieldWidget: Row(
        spacing: 6,
        children: [
          _ActionButton(
            parentWidget: this, 
            isYesButton: true, 
            enabled: fieldState.enabled,
          ),
          _ActionButton(
            parentWidget: this, 
            isYesButton: false, 
            enabled: fieldState.enabled,
          ),
        ],
      ),
    );
  }
}

/// Single option button toggling the boolean controller value.
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.parentWidget, 
    required this.isYesButton, 
    required this.enabled,
  });

  final bool isYesButton;
  final bool enabled;
  final BooleanFormField parentWidget;

  FooFieldController<bool> get _controller => parentWidget.controller;

  @override
  Widget build(BuildContext context) {
    return SelectionCard(
      enabled: enabled,
      onTap: _onTap,
      isSelected: _controller.value == isYesButton,
      defaultTextStyle: parentWidget.textStyle,
      child: Text(
        isYesButton ? 
          parentWidget.yesText 
          :parentWidget.noText,
        ),
    );
  }


  void _onTap() {
    if (_controller.value == isYesButton) {
      _controller.value = null;
    } else {
      _controller.value = isYesButton;
    }
  }
}
