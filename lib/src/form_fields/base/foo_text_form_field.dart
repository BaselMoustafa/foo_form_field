
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foo_form_field/foo_form_field.dart';

class FooTextFormField extends StatefulWidget {

  const FooTextFormField({
    super.key,
    this.groupId = EditableText,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.forceErrorText,
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

  final Object groupId;
  final FooFieldController<String>? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final String? forceErrorText;
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
  final void Function(String? value)? onChanged;
  final GestureTapCallback? onTap;
  final bool? onTapAlwaysCalled;
  final TapRegionCallback? onTapOutside;
  final TapRegionUpCallback? onTapUpOutside;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final FormFieldErrorBuilder? errorBuilder;
  final List<TextInputFormatter>? inputFormatters;
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
  State<StatefulWidget> createState()=> _FooTextFormFieldState();
}

class _FooTextFormFieldState extends State<FooTextFormField> {
  
  late final FooFieldController<String> _controller;
  bool _controllerLocallyInitialized = false;
  final GlobalKey<FormFieldState<String>> _formFieldKey = GlobalKey<FormFieldState<String>>();

  @override
  void initState() {
    super.initState();
    if(widget.controller != null){
      _controller = widget.controller!;
    } else {
      _controller = FooFieldController<String>();
      _controllerLocallyInitialized = true;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.setFormFieldState(_formFieldKey.currentState!);
      _controller.addListener(_notifyChangeInValue);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_notifyChangeInValue);
    if(_controllerLocallyInitialized){
      _controller.dispose();
    }
    super.dispose();
  }

  void _notifyChangeInValue(){
    setState(() {});
    widget.onChanged?.call(_controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _formFieldKey,
      enabled: _controller.enabled,

      //Gives access to the TextFormField's properties
      groupId: widget.groupId,
      initialValue: widget.initialValue,
      focusNode: widget.focusNode,
      forceErrorText: widget.forceErrorText,
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
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onTapAlwaysCalled: widget.onTapAlwaysCalled?? false,
      onTapOutside: widget.onTapOutside,
      onTapUpOutside: widget.onTapUpOutside,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      validator: widget.validator,
      errorBuilder: widget.errorBuilder,
      inputFormatters: widget.inputFormatters,
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
    );
  }
}