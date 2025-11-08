import 'package:flutter/widgets.dart';
import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/core/models/range.dart';

class RangeFieldController<T> extends ValueFieldController<Range<T?>> {

  late final ValueFieldController<T> minValueController;
  late final ValueFieldController<T> maxValueController;

  RangeFieldController({
    super.enabled,
    super.initialValue,
  }):
  minValueController = ValueFieldController<T>(
    initialValue: initialValue?.min,
    enabled: enabled,
  ), 
  maxValueController = ValueFieldController<T>(
    initialValue: initialValue?.max,
    enabled: enabled,
  );

  @override
  void setFormFieldState(FormFieldState<Range<T?>> formFieldState) {
    super.setFormFieldState(formFieldState);
    _invokeSyncers();
  }

  @override
  set enabled(bool value) {
    minValueController.enabled = value;
    maxValueController.enabled = value;
    super.enabled = value;
  }

  @override
  void save() {
    return excute(
      toExecute: (FormFieldState<Range<T?>> formFieldState) {
        minValueController.save();
        maxValueController.save();
        super.save();
      },
    );
  }

  @override
  bool validate() {
    return excute<bool>(
      toExecute: (FormFieldState<Range<T?>> formFieldState) {
        bool isValidMin = minValueController.validate();
        bool isValidMax = maxValueController.validate();
        if (isValidMin && isValidMax) {
          return super.validate();
        }
        return false;
      },
    );
  }

  void _invokeSyncers(){
    addListener(_onRangeChanged);
    minValueController.addListener(_onMinValueChanged);
    maxValueController.addListener(_onMaxValueChanged);
  }
  void _removeSyncers(){
    removeListener(_onRangeChanged);
    minValueController.removeListener(_onMinValueChanged);
    maxValueController.removeListener(_onMaxValueChanged);
  }

  void _onRangeChanged(){
    if (value?.min==minValueController.value && value?.max==maxValueController.value) {
      return;
    }
    minValueController.value = value?.min;
    maxValueController.value = value?.max;
  }

  void _onMinValueChanged(){
    if (value?.min==minValueController.value) {
      return;
    }
    minValueController.value = value?.min;
  }

  void _onMaxValueChanged(){
    if (value?.max==maxValueController.value) {
      return;
    }
    maxValueController.value = value?.max;
  }

  @override
  void dispose() {
    _removeSyncers();
    minValueController.dispose();
    maxValueController.dispose();
    super.dispose();
  }
  
}
