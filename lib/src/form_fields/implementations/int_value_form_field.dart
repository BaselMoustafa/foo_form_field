import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/core/formatters/integer_value_input_formatter.dart';

class IntValueFormField extends StatefulWidget {
  const IntValueFormField({
    super.key,
    required this.controller,
    this.formatter,
    this.groupId = EditableText,
    this.focusNode,
    this.forceErrorText,
    this.decoration,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign,
    this.textAlignVertical,
    this.autofocus,
    this.readOnly,
    this.showCursor,
    this.obscuringCharacter,
    this.obscureText,
    this.autocorrect,
    this.enableSuggestions,
    this.maxLengthEnforcement,
    this.expands,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onTapAlwaysCalled,
    this.onTapOutside,
    this.onTapUpOutside,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.errorBuilder,
    this.ignorePointers,
    this.cursorWidth,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.cursorErrorColor,
    this.keyboardAppearance,
    this.scrollPadding,
    this.enableInteractiveSelection,
    this.selectionControls,
    this.buildCounter,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode,
    this.scrollController,
    this.restorationId,
    this.enableIMEPersonalizedLearning,
    this.mouseCursor,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.undoController,
    this.onAppPrivateCommand,
    this.cursorOpacityAnimates,
    this.selectionHeightStyle,
    this.selectionWidthStyle, 
    this.dragStartBehavior, 
    this.contentInsertionConfiguration, 
    this.clipBehavior, 
    this.stylusHandwritingEnabled, 
    this.canRequestFocus, 
  });

  final FooFieldController<int> controller;
  final IntegerValueInputFormatter? formatter;

  final Object groupId;
  final FocusNode? focusNode;
  final String? forceErrorText;
  final InputDecoration? decoration;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool? autofocus;
  final bool? readOnly;
  final bool? showCursor;
  final String? obscuringCharacter;
  final bool? obscureText;
  final bool? autocorrect;
  final bool? enableSuggestions;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final bool? expands;
  final int? maxLength;
  final void Function(String? value)? onChanged;
  final GestureTapCallback? onTap;
  final bool? onTapAlwaysCalled;
  final TapRegionCallback? onTapOutside;
  final TapRegionUpCallback? onTapUpOutside;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String?>? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final FormFieldErrorBuilder? errorBuilder;
  final bool? ignorePointers;
  final double? cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets? scrollPadding;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;
  final ScrollController? scrollController;
  final String? restorationId;
  final bool? enableIMEPersonalizedLearning;
  final MouseCursor? mouseCursor;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final UndoHistoryController? undoController;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final bool? cursorOpacityAnimates;
  final BoxHeightStyle? selectionHeightStyle;
  final BoxWidthStyle? selectionWidthStyle;
  final DragStartBehavior? dragStartBehavior;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final Clip? clipBehavior;
  final bool? stylusHandwritingEnabled;
  final bool? canRequestFocus;

  @override
  State<IntValueFormField> createState() => _IntValueFormFieldState();
}

class _IntValueFormFieldState extends State<IntValueFormField> {

  late final FooFieldController<String> _stringController;

  @override
  void initState() {
    super.initState();
    _stringController = FooFieldController<String>(
      initialValue: widget.controller.value?.toString(),
      enabled: widget.controller.enabled,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _stringController.addListener(_notifyIntegerController);
    });
  }
  
  @override
  void dispose() {
    _stringController.removeListener(_notifyIntegerController);
    _stringController.dispose();
    super.dispose();
  }

  void _notifyIntegerController(){
    widget.controller.value = int.tryParse(_stringController.value??"");
  }
  
  @override
  Widget build(BuildContext context) {
    return FooTextFormField(
      controller: _stringController,
      focusNode: widget.focusNode,
      forceErrorText: widget.forceErrorText,
      decoration: widget.decoration,
      textInputAction: widget.textInputAction,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      expands: widget.expands,
      maxLength: widget.maxLength,
      onTap: widget.onTap,
      onTapAlwaysCalled: widget.onTapAlwaysCalled,
      onTapOutside: widget.onTapOutside,
      onTapUpOutside: widget.onTapUpOutside,
      onEditingComplete: widget.onEditingComplete,
      errorBuilder: widget.errorBuilder,
      ignorePointers: widget.ignorePointers,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      cursorErrorColor: widget.cursorErrorColor,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      selectionControls: widget.selectionControls,
      buildCounter: widget.buildCounter,
      scrollPhysics: widget.scrollPhysics,
      autofillHints: widget.autofillHints,
      autovalidateMode: widget.autovalidateMode,
      scrollController: widget.scrollController,
      restorationId: widget.restorationId,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      mouseCursor: widget.mouseCursor,
      spellCheckConfiguration: widget.spellCheckConfiguration,
      magnifierConfiguration: widget.magnifierConfiguration,
      undoController: widget.undoController,
      onAppPrivateCommand: widget.onAppPrivateCommand,
      cursorOpacityAnimates: widget.cursorOpacityAnimates,
      selectionHeightStyle: widget.selectionHeightStyle,
      selectionWidthStyle: widget.selectionWidthStyle,
      dragStartBehavior: widget.dragStartBehavior,
      contentInsertionConfiguration: widget.contentInsertionConfiguration,
      clipBehavior: widget.clipBehavior,  
      stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
      canRequestFocus: widget.canRequestFocus,
      keyboardType: TextInputType.numberWithOptions(
        signed: _effectiveFormatter.allowNegative,
        decimal: false,
      ),
      inputFormatters: [
        _effectiveFormatter,
      ],
      onChanged: (String? value){
        if (_validToNotifyUserBy(value)) {
          widget.onChanged?.call(value);
        }
      },
      onFieldSubmitted: (String? value){
        if (_validToNotifyUserBy(value)) {
          widget.onFieldSubmitted?.call(value);
        }
      },
      onSaved: (String? value){
        if (_validToNotifyUserBy(value)) {
          widget.onSaved?.call(value);
        }
      },
      validator: (String? value){
        if(value!=null && _effectiveFormatter.validate(value)!=null){
          return _effectiveFormatter.validate(value);
        }
        return widget.validator?.call(value);
      },
    );
  }

  bool _validToNotifyUserBy(String? value){
    return value==null || _effectiveFormatter.validate(value) == null;
  }

  IntegerValueInputFormatter get _effectiveFormatter{
    return widget.formatter?? IntegerValueInputFormatter();
  }
}