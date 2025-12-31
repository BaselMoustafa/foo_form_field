
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../foo_form_field.dart';
import '../../common/extentions/foo_text_formatter_list_extension.dart';

class FooTextFormField<Value> extends StatefulWidget {
  const FooTextFormField({
    super.key,
    required this.controller,
    this.fooTextFormatters = const [],
    this.keyboardType,
    this.properties,
  });

  /// Controller that provides the value mapping between string input and client type.
  final FooTextEditingController<Value> controller;
  // /// Additional formatters applied after the standard `TextFormField` formatters.
  final TextInputType? keyboardType;
  final List<FooTextFormatter> fooTextFormatters;
  /// Optional helper carrying the configuration for the inner `TextFormField`.
  final TextFormFieldProperties<Value>? properties;

  @override
  State<StatefulWidget> createState() => _FooTextFormFieldState<Value>();
}

class _FooTextFormFieldState<Value> extends State<FooTextFormField<Value>> {

  final GlobalKey<FormFieldState<String>> _formFieldKey = GlobalKey<FormFieldState<String>>();

  TextFormFieldProperties<Value>? get _properties => widget.properties;

  Value? _latestValue;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.setFormFieldState(_formFieldKey.currentState!);
      widget.controller.addListener(
        _notifyChangeInValue,
      );
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(
      _notifyChangeInValue,
    );
    super.dispose();
  }

  /// Propagates controller updates to the widget tree and optional callbacks.
  void _notifyChangeInValue() {
    setState(() {});
    if (_shouldNotifyUser) {
      widget.properties?.onChanged?.call(widget.controller.value);
      _latestValue = widget.controller.value;
    }
  }

  bool get _shouldNotifyUser {
    final value = widget.controller.value;
    if(value == null && _latestValue == null){
      return false;
    }
    if(value == null && _latestValue != null){
      return true;
    }
    if(value != null && _latestValue == null){
      return true;
    }
    return ! widget.controller.areEqual(
      value as Value, _latestValue as Value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _formFieldKey,
      keyboardType: widget.keyboardType,
      enabled: widget.controller.enabled,
      initialValue: widget.controller.initialValueAsFieldValue,
      forceErrorText: widget.controller.forcedErrorText,

      //Gives access to the TextFormField's properties
      onChanged: (_){
        if(_shouldNotifyUser){
          widget.controller.value = widget.controller.value;
        }
        _latestValue = widget.controller.value;
      },
      onFieldSubmitted: (String? value) => _properties?.onFieldSubmitted?.call(
        widget.controller.mapper.toValue(value),
      ),
      onSaved: (String? value) => _properties?.onSaved?.call(
        widget.controller.mapper.toValue(value),
      ),
      validator: (String? value) {
        if (value != null && widget.fooTextFormatters.validate(value) != null) {
          return widget.fooTextFormatters.validate(value);
        }
        return _properties?.validator?.call(widget.controller.value);
      },
      onTapOutside: _properties?.onTapOutside ??
        (_) => FocusScope.of(context).unfocus(),
      inputFormatters: [
        ...widget.fooTextFormatters,
        ...?_properties?.inputFormatters,
      ],
      groupId: _properties?.groupId ?? EditableText,
      focusNode: _properties?.focusNode,
      decoration: _properties?.decoration,
      textCapitalization: _properties?.textCapitalization ?? TextCapitalization.none,
      textInputAction: _properties?.textInputAction,
      style: _properties?.style,
      strutStyle: _properties?.strutStyle,
      textDirection: _properties?.textDirection,
      textAlign: _properties?.textAlign ?? TextAlign.start,
      textAlignVertical: _properties?.textAlignVertical,
      autofocus: _properties?.autofocus ?? false,
      readOnly: _properties?.readOnly ?? false,
      showCursor: _properties?.showCursor ?? false,
      obscuringCharacter: _properties?.obscuringCharacter ?? '•',
      obscureText: _properties?.obscureText ?? false,
      autocorrect: _properties?.autocorrect ?? true,
      smartDashesType: _properties?.smartDashesType,
      smartQuotesType: _properties?.smartQuotesType,
      enableSuggestions: _properties?.enableSuggestions ?? true,
      maxLengthEnforcement: _properties?.maxLengthEnforcement,
      maxLines: _properties?.maxLines??1,
      minLines: _properties?.minLines,
      expands: _properties?.expands ?? false,
      maxLength: _properties?.maxLength,
      onTap: _properties?.onTap,
      onTapAlwaysCalled: _properties?.onTapAlwaysCalled ?? false,
      onTapUpOutside: _properties?.onTapUpOutside,
      onEditingComplete: _properties?.onEditingComplete,
      errorBuilder: _properties?.errorBuilder,
      ignorePointers: _properties?.ignorePointers,
      cursorWidth: _properties?.cursorWidth ?? 2.0,
      cursorHeight: _properties?.cursorHeight,
      cursorRadius: _properties?.cursorRadius,
      cursorColor: _properties?.cursorColor,
      cursorErrorColor: _properties?.cursorErrorColor,
      keyboardAppearance: _properties?.keyboardAppearance,
      scrollPadding: _properties?.scrollPadding ?? const EdgeInsets.all(20.0),
      enableInteractiveSelection: _properties?.enableInteractiveSelection,
      selectionControls: _properties?.selectionControls,
      buildCounter: _properties?.buildCounter,
      scrollPhysics: _properties?.scrollPhysics,
      autofillHints: _properties?.autofillHints,
      autovalidateMode: _properties?.autovalidateMode,
      scrollController: _properties?.scrollController,
      restorationId: _properties?.restorationId,
      enableIMEPersonalizedLearning: _properties?.enableIMEPersonalizedLearning ?? true,
      mouseCursor: _properties?.mouseCursor,
      spellCheckConfiguration: _properties?.spellCheckConfiguration,
      magnifierConfiguration: _properties?.magnifierConfiguration,
      undoController: _properties?.undoController,
      onAppPrivateCommand: _properties?.onAppPrivateCommand,
      cursorOpacityAnimates: _properties?.cursorOpacityAnimates,
      selectionHeightStyle: _properties?.selectionHeightStyle ?? BoxHeightStyle.tight,
      selectionWidthStyle: _properties?.selectionWidthStyle ?? BoxWidthStyle.tight,
      dragStartBehavior: _properties?.dragStartBehavior ?? DragStartBehavior.start,
      contentInsertionConfiguration: _properties?.contentInsertionConfiguration,
      clipBehavior: _properties?.clipBehavior ?? Clip.hardEdge,
      stylusHandwritingEnabled: _properties?.stylusHandwritingEnabled ?? true,
      canRequestFocus: _properties?.canRequestFocus ?? true,
    );
  }
}
