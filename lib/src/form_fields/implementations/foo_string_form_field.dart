// part of '../exporter.dart';

// /// Specialized form field that binds a string-based controller to `TextFormField`.
// class FooStringFormField<O> extends StatefulWidget {
//   const FooStringFormField({
//     super.key,
//     required this.controller,
//     this.fooInputFormatters,
//     this.keyboardType,
//     this.properties,
//   });

//   /// Controller that provides the value mapping between string input and client type.
//   final FooFieldController<O, String> controller;

//   /// Additional formatters applied after the standard `TextFormField` formatters.
//   final List<FooTextInputFormatter>? fooInputFormatters;
//   final TextInputType? keyboardType;

//   /// Optional helper carrying the configuration for the inner `TextFormField`.
//   final TextFormFieldProperties<O>? properties;

//   @override
//   State<StatefulWidget> createState() => _FooStringFormFieldState<O>();
// }

// class _FooStringFormFieldState<O> extends State<FooStringFormField<O>> {
//   /// Key that exposes the inner `FormFieldState` for the controller.
//   final GlobalKey<FormFieldState<String>> _formFieldKey =
//       GlobalKey<FormFieldState<String>>();

//   TextFormFieldProperties<O>? get _properties => widget.properties;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       widget.controller.setFormFieldState(_formFieldKey.currentState!);
//       widget.controller.addListener(_notifyChangeInValue);
//     });
//   }

//   @override
//   void dispose() {
//     widget.controller.removeListener(_notifyChangeInValue);
//     super.dispose();
//   }

//   /// Propagates controller updates to the widget tree and optional callbacks.
//   void _notifyChangeInValue() {
//     setState(() {});
//     if (widget.controller.isValueChanged) {
//       widget.properties?.onChanged?.call(widget.controller.value);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       key: _formFieldKey,
//       keyboardType: widget.keyboardType,
//       enabled: widget.controller.enabled,
//       initialValue: widget.controller.initialValueAsFieldValue,
//       forceErrorText: widget.controller.forcedErrorText,

//       //Gives access to the TextFormField's properties
//       groupId: _properties?.groupId ?? EditableText,
//       focusNode: _properties?.focusNode,
//       decoration: _properties?.decoration,
//       textCapitalization:
//           _properties?.textCapitalization ?? TextCapitalization.none,
//       textInputAction: _properties?.textInputAction,
//       style: _properties?.style,
//       strutStyle: _properties?.strutStyle,
//       textDirection: _properties?.textDirection,
//       textAlign: _properties?.textAlign ?? TextAlign.start,
//       textAlignVertical: _properties?.textAlignVertical,
//       autofocus: _properties?.autofocus ?? false,
//       readOnly: _properties?.readOnly ?? false,
//       showCursor: _properties?.showCursor ?? false,
//       obscuringCharacter: _properties?.obscuringCharacter ?? '•',
//       obscureText: _properties?.obscureText ?? false,
//       autocorrect: _properties?.autocorrect ?? true,
//       smartDashesType: _properties?.smartDashesType,
//       smartQuotesType: _properties?.smartQuotesType,
//       enableSuggestions: _properties?.enableSuggestions ?? true,
//       maxLengthEnforcement: _properties?.maxLengthEnforcement,
//       maxLines: _properties?.maxLines,
//       minLines: _properties?.minLines,
//       expands: _properties?.expands ?? false,
//       maxLength: _properties?.maxLength,
//       onTap: _properties?.onTap,
//       onTapAlwaysCalled: _properties?.onTapAlwaysCalled ?? false,
//       onTapOutside:
//           _properties?.onTapOutside ??
//           (_) {
//             FocusScope.of(context).unfocus();
//           },
//       onTapUpOutside: _properties?.onTapUpOutside,
//       onEditingComplete: _properties?.onEditingComplete,
//       errorBuilder: _properties?.errorBuilder,
//       inputFormatters: [
//         ...?_properties?.inputFormatters,
//         ..._fooInputFormatters,
//       ],
//       ignorePointers: _properties?.ignorePointers,
//       cursorWidth: _properties?.cursorWidth ?? 2.0,
//       cursorHeight: _properties?.cursorHeight,
//       cursorRadius: _properties?.cursorRadius,
//       cursorColor: _properties?.cursorColor,
//       cursorErrorColor: _properties?.cursorErrorColor,
//       keyboardAppearance: _properties?.keyboardAppearance,
//       scrollPadding: _properties?.scrollPadding ?? const EdgeInsets.all(20.0),
//       enableInteractiveSelection: _properties?.enableInteractiveSelection,
//       selectionControls: _properties?.selectionControls,
//       buildCounter: _properties?.buildCounter,
//       scrollPhysics: _properties?.scrollPhysics,
//       autofillHints: _properties?.autofillHints,
//       autovalidateMode: _properties?.autovalidateMode,
//       scrollController: _properties?.scrollController,
//       restorationId: _properties?.restorationId,
//       enableIMEPersonalizedLearning:
//           _properties?.enableIMEPersonalizedLearning ?? true,
//       mouseCursor: _properties?.mouseCursor,
//       spellCheckConfiguration: _properties?.spellCheckConfiguration,
//       magnifierConfiguration: _properties?.magnifierConfiguration,
//       undoController: _properties?.undoController,
//       onAppPrivateCommand: _properties?.onAppPrivateCommand,
//       cursorOpacityAnimates: _properties?.cursorOpacityAnimates,
//       selectionHeightStyle:
//           _properties?.selectionHeightStyle ?? BoxHeightStyle.tight,
//       selectionWidthStyle:
//           _properties?.selectionWidthStyle ?? BoxWidthStyle.tight,
//       dragStartBehavior:
//           _properties?.dragStartBehavior ?? DragStartBehavior.start,
//       contentInsertionConfiguration: _properties?.contentInsertionConfiguration,
//       clipBehavior: _properties?.clipBehavior ?? Clip.hardEdge,
//       stylusHandwritingEnabled: _properties?.stylusHandwritingEnabled ?? true,
//       canRequestFocus: _properties?.canRequestFocus ?? true,
//       onFieldSubmitted: (String? value) => _properties?.onFieldSubmitted?.call(
//         widget.controller.mapper.toValue(value),
//       ),
//       onSaved: (String? value) => _properties?.onSaved?.call(
//         widget.controller.mapper.toValue(value),
//       ),
//       onChanged: (String? value) {
//         widget.controller.value = widget.controller.mapper.toValue(value);
//         if (_validToNotifyUserBy(value)) {
//           _properties?.onChanged?.call(widget.controller.value);
//         }
//       },
//       validator: (String? value) {
//         if (value != null && _fooInputFormatters.validate(value) != null) {
//           return _fooInputFormatters.validate(value);
//         }
//         return _properties?.validator?.call(widget.controller.value);
//       },
//     );
//   }

//   /// Ensures custom formatters approve the value before raising `onChanged`.
//   bool _validToNotifyUserBy(String? value) {
//     if (value == null) {
//       return true;
//     }
//     return _fooInputFormatters.validate(value) == null;
//   }

//   List<FooTextInputFormatter> get _fooInputFormatters =>
//       widget.fooInputFormatters ?? [];
// }
