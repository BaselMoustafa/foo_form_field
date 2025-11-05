import 'package:flutter/material.dart';
import 'package:foo_form_field/src/core/controllers/foo_field_controller.dart';
import 'package:foo_form_field/src/core/widgets/field_with_error_text_widget.dart';
import 'package:foo_form_field/src/core/widgets/selection_card.dart';
import 'package:foo_form_field/src/form_fields/base/foo_form_field.dart';

class BooleanFormField extends StatefulWidget {
  const BooleanFormField({
    super.key,
    this.yesText = "Yes",
    this.noText = "No",
    this.controller,
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

  final FooFieldController<bool>? controller;
  final Widget Function(BuildContext context, bool enabled, bool? value)? builder;
  final void Function(bool? value)? onSaved;
  final String? Function(bool? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final FormFieldErrorBuilder? errorBuilder;
  final String? forceErrorText;
  final String? restorationId;
  final void Function(bool? value)? onChanged;

  @override
  State<BooleanFormField> createState() => _BooleanFormFieldState();
}

class _BooleanFormFieldState extends State<BooleanFormField> {

  late final FooFieldController<bool> _controller;
  bool _controllerLocallyInitialized = false;

  @override
  void initState() {
    super.initState();
    if(widget.controller != null){
      _controller = widget.controller!;
    } else {
      _controller = FooFieldController<bool>();
      _controllerLocallyInitialized = true;
    }
  }

  @override
  void dispose() {
    if (_controllerLocallyInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FooFormField<bool>(
      controller: _controller,
      onSaved: widget.onSaved,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      errorBuilder: widget.errorBuilder,
      forceErrorText: widget.forceErrorText,
      restorationId: widget.restorationId,
      onChanged: widget.onChanged,
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, bool enabled, bool? value , String? errorText){
    return FieldWithErrorTextWidget(
      errorText: errorText,
      fieldWidget: widget.builder!=null? widget.builder!(context, enabled, value): Row(
        spacing: 6,
        children: [
          _ActionButton(
            state: this, 
            isYesButton: true,
          ),
      
          _ActionButton(
            state: this, 
            isYesButton: false,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.state,
    required this.isYesButton,
  });

  final _BooleanFormFieldState state;
  final bool isYesButton;

  @override
  Widget build(BuildContext context) {
    return SelectionCard(
      enabled: state._controller.enabled,
      onTap: _onTap, 
      isSelected: state._controller.value == isYesButton, 
      child: Text(
        isYesButton ? state.widget.yesText : state.widget.noText
      ),
    );
  }

  void _onTap() {
    if(state._controller.value == isYesButton){
      state._controller.value = null;
    } else {
      state._controller.value = isYesButton;
    }
    state.widget.onChanged?.call(state._controller.value);
  }
}
