part of '../exporter.dart';

class ConvertableRangeFormField<O,I,B extends ConvertableRangeBoundryFieldController<O,I>> extends StatelessWidget {
  const ConvertableRangeFormField({
    super.key,
    required this.controller,
    required this.rangeValidator,
    required this.minFieldBuilder,
    required this.maxFieldBuilder,
    this.layoutBuilder,
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.restorationId,
    this.onChanged,
  });

  final ConvertableRangeFieldController<O,I,B> controller;
  final RangeValidator<O> rangeValidator; 
  final Widget Function(BuildContext context,B minValueController,I? value) minFieldBuilder;
  final Widget Function(BuildContext context,B maxValueController,I? value) maxFieldBuilder;

  final Widget Function(BuildContext context,Widget minField,Widget maxField)? layoutBuilder;

  final void Function(Range<O?>? value)? onSaved;
  final String? Function(Range<O?>? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final String? restorationId;
  final void Function(Range<O?>? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return FooFormField<Range<O>,Range<I>>(
      builder: _builder,
      controller: controller, 
      onSaved: onSaved,
      autovalidateMode: autovalidateMode,
      restorationId: restorationId,
      onChanged: onChanged,
      validator: _validator,
    );
  }

  String? _validator(Range<O>? value){
    if (value == null) {
      return validator?.call(value);
    }

    String? equalityError = rangeValidator.validateEquality(value);
    if (equalityError != null) {
      return equalityError;
    }

    String? minError = rangeValidator.validateMin(value);
    if (minError != null) {
      return minError;
    }

    return validator?.call(value);
  }

  Widget _builder(BuildContext context,Range<I>? value){
    final minField = minFieldBuilder(context,controller.minValueController,value?.min);
    final maxField = maxFieldBuilder(context,controller.maxValueController,value?.max);

    return FieldWithErrorTextWidget(
      errorText: controller.errorText,
      fieldWidget: layoutBuilder?.call(context,minField,maxField) ?? Row(
        spacing: 10,
        children: [
          Expanded(child: minField),
          Expanded(child: maxField),
        ],
      ),
    );
  }

}