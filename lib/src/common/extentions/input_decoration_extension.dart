import 'package:flutter/material.dart';

extension InputDecorationExtension on InputDecoration? {

  InputDecoration merge({
    required InputDecoration? secondary,
  }) {

    if (this == null) {
      return secondary ?? InputDecoration();
    }

    return InputDecoration(
      hintText: this?.hintText ?? secondary?.hintText,
      hintStyle: this?.hintStyle ?? secondary?.hintStyle,
      border: this?.border ?? secondary?.border,
      enabledBorder: this?.enabledBorder ?? secondary?.enabledBorder,
      focusedBorder: this?.focusedBorder ?? secondary?.focusedBorder,
      errorBorder: this?.errorBorder ?? secondary?.errorBorder,
      disabledBorder: this?.disabledBorder ?? secondary?.disabledBorder,
      focusedErrorBorder: this?.focusedErrorBorder ?? secondary?.focusedErrorBorder,
      contentPadding: this?.contentPadding ?? secondary?.contentPadding,
      isDense: this?.isDense ?? secondary?.isDense,
      prefixIcon: this?.prefixIcon ?? secondary?.prefixIcon,
      suffixIcon: this?.suffixIcon ?? secondary?.suffixIcon,
      filled: this?.filled ?? secondary?.filled,
      fillColor: this?.fillColor ?? secondary?.fillColor,
      prefixIconConstraints:this?.prefixIconConstraints ?? secondary?.prefixIconConstraints,
      suffixIconConstraints:this?.suffixIconConstraints ?? secondary?.suffixIconConstraints,
      prefixIconColor: this?.prefixIconColor ?? secondary?.prefixIconColor,
      suffixIconColor: this?.suffixIconColor ?? secondary?.suffixIconColor,
      enabled: this?.enabled ?? secondary?.enabled ?? false,
      error: this?.error ?? secondary?.error,
      isCollapsed: this?.isCollapsed ?? secondary?.isCollapsed,
      hint: this?.hint ?? secondary?.hint,
      hintTextDirection: this?.hintTextDirection ?? secondary?.hintTextDirection,
      floatingLabelBehavior:  this?.floatingLabelBehavior ?? secondary?.floatingLabelBehavior,
      focusColor: this?.focusColor ?? secondary?.focusColor,
      hoverColor: this?.hoverColor ?? secondary?.hoverColor,
      helper: this?.helper ?? secondary?.helper,
      helperMaxLines: this?.helperMaxLines ?? secondary?.helperMaxLines,
      helperStyle: this?.helperStyle ?? secondary?.helperStyle,
      helperText: this?.helperText ?? secondary?.helperText,
      counterText: this?.counterText ?? secondary?.counterText,
      counterStyle: this?.counterStyle ?? secondary?.counterStyle,
      hintFadeDuration: this?.hintFadeDuration ?? secondary?.hintFadeDuration,
      hintMaxLines: this?.hintMaxLines ?? secondary?.hintMaxLines,
      icon: this?.icon ?? secondary?.icon,
      iconColor: this?.iconColor ?? secondary?.iconColor,
      labelText: this?.labelText ?? secondary?.labelText,
      maintainHintSize:  this?.maintainHintSize ?? secondary?.maintainHintSize ?? false,
      prefix: this?.prefix ?? secondary?.prefix,
      suffix: this?.suffix ?? secondary?.suffix,
      prefixStyle: this?.prefixStyle ?? secondary?.prefixStyle,
      suffixStyle: this?.suffixStyle ?? secondary?.suffixStyle,
      prefixText: this?.prefixText ?? secondary?.prefixText,
      suffixText: this?.suffixText ?? secondary?.suffixText,
      semanticCounterText:  this?.semanticCounterText ?? secondary?.semanticCounterText,
      alignLabelWithHint: this?.alignLabelWithHint ?? secondary?.alignLabelWithHint,
      label: this?.label ?? secondary?.label,
      labelStyle: this?.labelStyle ?? secondary?.labelStyle,
      floatingLabelStyle: this?.floatingLabelStyle ?? secondary?.floatingLabelStyle,
      floatingLabelAlignment:  this?.floatingLabelAlignment ?? secondary?.floatingLabelAlignment,
      constraints: this?.constraints ?? secondary?.constraints,
      errorMaxLines: this?.errorMaxLines ?? secondary?.errorMaxLines,
      errorStyle: this?.errorStyle ?? secondary?.errorStyle,
      errorText: this?.errorText ?? secondary?.errorText,
      counter: this?.counter ?? secondary?.counter,
    );
  }

}
