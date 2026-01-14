
import 'package:flutter/material.dart';

import '../../foo_form_field.dart';
import '../common/models/controlled_field_state.dart';
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
  }); 

  final BoolFieldController controller;

  final String yesText;

  final String noText;

  final TextStyle? textStyle;

  final Widget Function(BuildContext context, ControlledFieldState<bool, bool> controlledFieldState)? builder;

  final FooFormFieldProperties<bool>? properties;

  @override
  Widget build(BuildContext context) {
    return ValueFormField<bool>(

      controller: controller,
      builder: _fieldBuilder,
      properties: properties,
    );
  }

  /// Builds the default toggle presentation using the controller value.
  Widget _fieldBuilder(BuildContext context, ControlledFieldState<bool, bool> controlledFieldState) {
    if (builder != null) {
      return builder!(context, controlledFieldState);
    }

    return FieldWithErrorTextWidget(
      errorText: controlledFieldState.errorText,
      fieldWidget: Row(
        spacing: 6,
        children: [
          _ActionButton(parentWidget: this, isYesButton: true),

          _ActionButton(parentWidget: this, isYesButton: false),
        ],
      ),
    );
  }
}

/// Single option button toggling the boolean controller value.
class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.parentWidget, required this.isYesButton});

  final bool isYesButton;
  final BooleanFormField parentWidget;

  ValueFieldController<bool> get _controller => parentWidget.controller;

  @override
  Widget build(BuildContext context) {
    return SelectionCard(
      enabled: _controller.enabled,
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
