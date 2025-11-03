import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_fields/src/core/formatters/integer_text_input_formatter.dart';
import 'package:flutter_form_fields/src/form_fields/base_flutter_form_field.dart';

class IntegerTextFormField extends BaseFlutterFormField<String> {

  final String? initialValue;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final bool readOnly;
  final void Function(String? value)? onChanged;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String?>? onFieldSubmitted;
  final void Function(String? value)? onSaved;
  final String? Function(String? value)? validator;
  final FormFieldErrorBuilder? errorBuilder;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final ScrollPhysics? scrollPhysics;
  final AutovalidateMode? autovalidateMode;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final bool canRequestFocus;

  final String invalidIntegerMessage;
  final IntegerTextInputFormatter inputFormatter;

  const IntegerTextFormField({
    super.key, 
    super.controller,
    this.initialValue,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.style,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofocus = false,
    this.readOnly = false,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.errorBuilder,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.cursorErrorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.scrollPhysics,
    this.autovalidateMode,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.canRequestFocus = true,
    this.invalidIntegerMessage = "Invalid",
    this.inputFormatter = const IntegerTextInputFormatter(),
  });

  @override
  State<IntegerTextFormField> createState() => _IntegerTextFormFieldState();
}

class _IntegerTextFormFieldState extends State<IntegerTextFormField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      focusNode: widget.focusNode,
      decoration: widget.decoration,
      style: widget.style,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      errorBuilder: widget.errorBuilder ,
      enabled: widget.enabled,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      cursorErrorColor: widget.cursorErrorColor,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      scrollPhysics: widget.scrollPhysics,
      autovalidateMode: widget.autovalidateMode,
      dragStartBehavior: widget.dragStartBehavior,
      clipBehavior: widget.clipBehavior,
      canRequestFocus: widget.canRequestFocus,
      keyboardType: TextInputType.number,
      inputFormatters: [widget.inputFormatter],  
      onChanged: (String? value) =>widget.onChanged?.call(_valueToReturn(value)),
      onSaved: (String? value)=>widget.onSaved?.call(_valueToReturn(value)),
      onFieldSubmitted: (String? value) =>widget.onFieldSubmitted?.call(_valueToReturn(value)),    
      validator: (String? value){
        if(value != null && widget.inputFormatter.matches(value) != null){
          return widget.inputFormatter.matches(value);
        }
        return widget.validator?.call(value);
      },      
    );
  }  

  String? _valueToReturn(String? value) {
    if(value != null && widget.inputFormatter.matches(value) != null){
      return widget.inputFormatter.matches(value);
    }
    return value;
  }
  
}