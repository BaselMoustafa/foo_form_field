
import 'package:flutter/material.dart';

import '../../../foo_form_field.dart';
import 'input_decoration_extension.dart';

extension FooFormFieldPropertiesExtension<T> on TextFormFieldProperties<T>? {
  
  TextFormFieldProperties<T> merge({
    required TextFormFieldProperties<T>? secondary,
  }) {

    if (this == null) {
      return secondary ?? TextFormFieldProperties<T>();
    }

    return TextFormFieldProperties(
      decoration: this?.decoration.merge(
        secondary: secondary?.decoration,
      ),
      autocorrect: this?.autocorrect ?? secondary?.autocorrect,
      autofillHints: this?.autofillHints ?? secondary?.autofillHints,
      autovalidateMode: this?.autovalidateMode ?? secondary?.autovalidateMode,
      buildCounter: this?.buildCounter ?? secondary?.buildCounter,
      cursorColor: this?.cursorColor ?? secondary?.cursorColor,
      cursorHeight: this?.cursorHeight ?? secondary?.cursorHeight,
      cursorOpacityAnimates:this?.cursorOpacityAnimates ?? secondary?.cursorOpacityAnimates,
      showCursor: this?.showCursor ?? secondary?.showCursor,
      textInputAction: this?.textInputAction ?? secondary?.textInputAction,
      textCapitalization: this?.textCapitalization ?? secondary?.textCapitalization,
      textDirection: this?.textDirection ?? secondary?.textDirection,
      textAlign: this?.textAlign ?? secondary?.textAlign,
      textAlignVertical: this?.textAlignVertical ?? secondary?.textAlignVertical,
      enableInteractiveSelection: this?.enableInteractiveSelection ?? secondary?.enableInteractiveSelection,
      enableSuggestions: this?.enableSuggestions ?? secondary?.enableSuggestions,
      enableIMEPersonalizedLearning: this?.enableIMEPersonalizedLearning ?? secondary?.enableIMEPersonalizedLearning,
      autofocus: this?.autofocus ?? secondary?.autofocus,
      obscureText: this?.obscureText ?? secondary?.obscureText,
      obscuringCharacter: this?.obscuringCharacter ?? secondary?.obscuringCharacter,
      readOnly: this?.readOnly ?? secondary?.readOnly,
      maxLength: this?.maxLength ?? secondary?.maxLength,
      maxLines: this?.maxLines ?? secondary?.maxLines,
      minLines: this?.minLines ?? secondary?.minLines,
      onTap: this?.onTap ?? secondary?.onTap,
      onFieldSubmitted: this?.onFieldSubmitted ?? secondary?.onFieldSubmitted,
      onTapOutside: this?.onTapOutside ?? secondary?.onTapOutside,
      onChanged: this?.onChanged ?? secondary?.onChanged,
      onEditingComplete: this?.onEditingComplete ?? secondary?.onEditingComplete,
      onSaved: this?.onSaved ?? secondary?.onSaved,
      canRequestFocus: this?.canRequestFocus ?? secondary?.canRequestFocus,
      clipBehavior: this?.clipBehavior ?? secondary?.clipBehavior,
      style: this?.style ?? secondary?.style,
      contentInsertionConfiguration:this?.contentInsertionConfiguration ?? secondary?.contentInsertionConfiguration,
      cursorErrorColor: this?.cursorErrorColor ?? secondary?.cursorErrorColor,
      cursorRadius: this?.cursorRadius ?? secondary?.cursorRadius,
      cursorWidth: this?.cursorWidth ?? secondary?.cursorWidth,
      dragStartBehavior: this?.dragStartBehavior ?? secondary?.dragStartBehavior,
      expands: this?.expands ?? secondary?.expands,
      inputFormatters: this?.inputFormatters ?? secondary?.inputFormatters,
      maxLengthEnforcement: this?.maxLengthEnforcement ?? secondary?.maxLengthEnforcement,
      mouseCursor: this?.mouseCursor ?? secondary?.mouseCursor,
      scrollPadding: this?.scrollPadding ?? secondary?.scrollPadding,
      scrollPhysics: this?.scrollPhysics ?? secondary?.scrollPhysics,
      errorBuilder: this?.errorBuilder ?? secondary?.errorBuilder,
      focusNode: this?.focusNode ?? secondary?.focusNode,
      ignorePointers: this?.ignorePointers ?? secondary?.ignorePointers,
      restorationId: this?.restorationId ?? secondary?.restorationId,
      selectionControls: this?.selectionControls ?? secondary?.selectionControls,
      selectionHeightStyle: this?.selectionHeightStyle ?? secondary?.selectionHeightStyle,
      selectionWidthStyle: this?.selectionWidthStyle ?? secondary?.selectionWidthStyle,
      keyboardAppearance: this?.keyboardAppearance ?? secondary?.keyboardAppearance,
      magnifierConfiguration: this?.magnifierConfiguration ?? secondary?.magnifierConfiguration,
      scrollController: this?.scrollController ?? secondary?.scrollController,
      onAppPrivateCommand: this?.onAppPrivateCommand ?? secondary?.onAppPrivateCommand,
      undoController: this?.undoController ?? secondary?.undoController,
      onTapUpOutside: this?.onTapUpOutside ?? secondary?.onTapUpOutside,
      smartDashesType: this?.smartDashesType ?? secondary?.smartDashesType,
      onTapAlwaysCalled: this?.onTapAlwaysCalled ?? secondary?.onTapAlwaysCalled,
      spellCheckConfiguration:this?.spellCheckConfiguration ?? secondary?.spellCheckConfiguration,
      smartQuotesType: this?.smartQuotesType ?? secondary?.smartQuotesType,
      strutStyle: this?.strutStyle ?? secondary?.strutStyle,
      stylusHandwritingEnabled:this?.stylusHandwritingEnabled ?? secondary?.stylusHandwritingEnabled,
      validator: this?.validator ?? secondary?.validator,
      groupId: this?.groupId ?? secondary?.groupId ?? Object(),
    );
  }

  TextFormFieldProperties<T> mergeDecoration({
    required InputDecoration? secondaryDecoration,
  }) {
    return merge(
      secondary: TextFormFieldProperties<T>(
        decoration: secondaryDecoration,
      ),
    );
  }

}
