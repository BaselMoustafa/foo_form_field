
import 'package:flutter/material.dart';
import '../../common/widgets/field_with_error_text_widget.dart';
import '../../../foo_form_field.dart';


/// Generic range form field that renders min/max inputs backed by a convertible controller.
class RangeFormField<
  Value extends Comparable, 
  BoundryController extends FooFieldController<Value>
> extends StatelessWidget {
  const RangeFormField({
    super.key,
    required this.controller,
    RangeValidator? rangeValidator,
    required this.minFieldBuilder,
    required this.maxFieldBuilder,
    this.builder,
    this.properties,
    this.stateProvider,
  }):rangeValidator = rangeValidator ?? const RangeValidator();

  final RangeFieldController<Value, BoundryController> controller;

  final RangeValidator rangeValidator;

  final Widget Function(BuildContext context) minFieldBuilder;
  
  final Widget Function(BuildContext context) maxFieldBuilder;

  final RangeFormFieldBuilder<Value>? builder;

  final FooFormFieldProperties<Range<Value>>? properties;
  
  final FooFormFieldStateProvider<Range<Value>>? stateProvider;

  @override
  Widget build(BuildContext context) {
    return FooFormField<Range<Value>>(
      stateProvider: stateProvider,
      builder: (BuildContext context, FooFormFieldState<Range<Value>> fieldState) {
        return _builder(context, fieldState);
      },
      controller: controller,
      properties: _properties,
    );
  }

  FooFormFieldProperties<Range<Value>> get _properties{
    var toReturn = properties?? FooFormFieldProperties<Range<Value>>();
    final currentValidator = toReturn.validator;

    toReturn = toReturn.copyWith(
      validator: (Range<Value>? value) {
         if (value == null) {
          return properties?.validator?.call(value);
        }

        String? equalityError = rangeValidator.validateEquality(value);

        if (equalityError != null) {
          return equalityError;
        }

        String? minError = rangeValidator.validateMin(value);
        if (minError != null) {
          return minError;
        }
        return currentValidator?.call(value);
      },
    );
    return toReturn;
  }


  /// Builds the inner field layout, wrapping it with error presentation.
  Widget _builder(BuildContext context, FooFormFieldState<Range<Value>> fieldState) {
    final minField = minFieldBuilder(context);
    final maxField = maxFieldBuilder(context);

    if (builder != null) {
      return builder!(context, minField, maxField, fieldState);
    }

    return FieldWithErrorTextWidget(
      errorText: fieldState.errorText,
      fieldWidget: Row(
        spacing: 10,
        children: [
          Expanded(child: minField),
          Expanded(child: maxField),
        ],
      ),
    );
  }
}
