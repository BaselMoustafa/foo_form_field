
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/core/extentions/foo_text_input_formatter_list_extension.dart';
import 'package:foo_form_field/src/core/formatters/foo_text_input_formatter.dart';

class FooTextFormField<O> extends StatefulWidget {

  const FooTextFormField({
    required this.controller,
    this.fooInputFormatters = const [],
    super.key,
    this.groupId = EditableText,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textCapitalization,
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
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions, 
    this.maxLengthEnforcement,
    this.maxLines,
    this.minLines,
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
    this.inputFormatters,
    this.ignorePointers,
    this.cursorWidth ,
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

  // ─── Final Fields ────────────────────────────────────────────────────────────────

  final FooFieldController<O,String> controller;
  final List<FooTextInputFormatter> fooInputFormatters;

  final List<TextInputFormatter>? inputFormatters;
  final Object groupId;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
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
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool? enableSuggestions;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final bool? expands;
  final int? maxLength;
  final void Function(O? value)? onChanged;
  final GestureTapCallback? onTap;
  final bool? onTapAlwaysCalled;
  final TapRegionCallback? onTapOutside;
  final TapRegionUpCallback? onTapUpOutside;
  final VoidCallback? onEditingComplete;
  final ValueChanged<O?>? onFieldSubmitted;
  final void Function(O? value)? onSaved;
  final String? Function(O? value)? validator;
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
  State<StatefulWidget> createState()=> _FooTextFormFieldState<O>();
}

class _FooTextFormFieldState<O> extends State<FooTextFormField<O>> {
  final GlobalKey<FormFieldState<String>> _formFieldKey = GlobalKey<FormFieldState<String>>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.setFormFieldState(_formFieldKey.currentState!);
      widget.controller.addListener(_notifyChangeInValue);
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_notifyChangeInValue);
    super.dispose();
  }

  void _notifyChangeInValue(){
    setState(() {});
    widget.onChanged?.call(widget.controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _formFieldKey,
      enabled: widget.controller.enabled,
      initialValue: widget.controller.initialValueAsFieldValue,
      forceErrorText: widget.controller.forcedErrorText,

      //Gives access to the TextFormField's properties
      groupId: widget.groupId,
      focusNode: widget.focusNode,
      decoration: widget.decoration,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization?? TextCapitalization.none,
      textInputAction: widget.textInputAction,
      style: widget.style,  
      strutStyle: widget.strutStyle,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign?? TextAlign.start,
      textAlignVertical: widget.textAlignVertical,
      autofocus: widget.autofocus?? false,
      readOnly: widget.readOnly?? false,
      showCursor: widget.showCursor,
      obscuringCharacter: widget.obscuringCharacter?? '•',
      obscureText: widget.obscureText?? false,
      autocorrect: widget.autocorrect?? true,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      enableSuggestions: widget.enableSuggestions?? true,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands?? false,
      maxLength: widget.maxLength,
      onTap: widget.onTap,
      onTapAlwaysCalled: widget.onTapAlwaysCalled?? false,
      onTapOutside: widget.onTapOutside,
      onTapUpOutside: widget.onTapUpOutside,
      onEditingComplete: widget.onEditingComplete,
      errorBuilder: widget.errorBuilder,
      inputFormatters: [
        ...?widget.inputFormatters,
        ...widget.fooInputFormatters,
      ],
      ignorePointers: widget.ignorePointers,
      cursorWidth: widget.cursorWidth?? 2.0,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      cursorErrorColor: widget.cursorErrorColor,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding?? const EdgeInsets.all(20.0),
      enableInteractiveSelection: widget.enableInteractiveSelection,
      selectionControls: widget.selectionControls,
      buildCounter: widget.buildCounter,
      scrollPhysics: widget.scrollPhysics,
      autofillHints: widget.autofillHints,
      autovalidateMode: widget.autovalidateMode,
      scrollController: widget.scrollController,
      restorationId: widget.restorationId,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning?? true,
      mouseCursor: widget.mouseCursor,
      spellCheckConfiguration: widget.spellCheckConfiguration,
      magnifierConfiguration: widget.magnifierConfiguration,
      undoController: widget.undoController,
      onAppPrivateCommand: widget.onAppPrivateCommand,
      cursorOpacityAnimates: widget.cursorOpacityAnimates,
      selectionHeightStyle: widget.selectionHeightStyle?? BoxHeightStyle.tight,
      selectionWidthStyle: widget.selectionWidthStyle?? BoxWidthStyle.tight,
      dragStartBehavior: widget.dragStartBehavior?? DragStartBehavior.start,
      contentInsertionConfiguration: widget.contentInsertionConfiguration,
      clipBehavior: widget.clipBehavior?? Clip.hardEdge,
      stylusHandwritingEnabled: widget.stylusHandwritingEnabled?? true,
      canRequestFocus: widget.canRequestFocus?? true,
      onFieldSubmitted: (String? value) {
        if(_validToNotifyUserBy(value)){
          widget.onFieldSubmitted?.call(widget.controller.value);
        }
      },
      onChanged: (String? value) {
        final newValue = widget.controller.fromFieldValue(value);
        widget.controller.value = newValue;
        if(_validToNotifyUserBy(value)){
          widget.onChanged?.call(widget.controller.value);
        }
      },
      onSaved: (String? value) {
        if(_validToNotifyUserBy(value)){
          widget.onSaved?.call(widget.controller.value);
        }
      },
      validator: (String? value) {
        if (value!=null && widget.fooInputFormatters.validate(value)!=null) {
          return widget.fooInputFormatters.validate(value);
        }
        return widget.validator?.call(widget.controller.value);
      },
    );
  }

  bool _validToNotifyUserBy(String? value){
    if(value==null){
      return true;
    }
    return widget.fooInputFormatters.validate(value) == null;
  }
}