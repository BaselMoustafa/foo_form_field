import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/core/models/range.dart';

class RangeFieldController<T> extends FooFieldController<Range<T?>, Range<T?>> {

  late final ValueFieldController<T> _minValueController;
  late final ValueFieldController<T> _maxValueController;

  RangeFieldController({
    super.enabled,
    super.initialValue,
  }):
  _minValueController = ValueFieldController<T>(
    initialValue: initialValue?.min,
    enabled: enabled,
  ), 
  _maxValueController = ValueFieldController<T>(
    initialValue: initialValue?.max,
    enabled: enabled,
  ),super(
    fromFieldValue: (range) => range,
    toFieldValue: (range) => range,
  );
  

  set minValue(T? value) => _excuteThenNotifyListeners(
    toExecute: () => _minValueController.value = value,
  );

  set maxValue(T? value) => _excuteThenNotifyListeners(
    toExecute: () => _maxValueController.value = value,
  );

  T? get minValue=>_minValueController.value;
  
  T? get maxValue=>_maxValueController.value;

  @override
  set value(Range<T?>? value) {
    _excuteThenNotifyListeners(
      toExecute: () {
        _minValueController.value = value?.min;
        _maxValueController.value = value?.max;
      },
    );
  }

  @override
  Range<T?>? get value => Range<T?>(
    min: _minValueController.value,
    max: _maxValueController.value,
  );

  @override
  void clear() => _excuteThenNotifyListeners(
    toExecute: () {
      _minValueController.clear();
      _maxValueController.clear();
    },
  );

  void clearMinValue() {
    return _excuteThenNotifyListeners(
      toExecute: () {
        _minValueController.clear();
      },
    );
  }

  void clearMaxValue() {
    return _excuteThenNotifyListeners(
      toExecute: () {
        _maxValueController.clear();
      },
    );
  }
  
  @override
  void save() {
    return _excuteThenNotifyListeners(
      toExecute: () {
        _minValueController.save();
        _maxValueController.save();
      },
    );
  }

  void saveMinValue() {
    return _excuteThenNotifyListeners(
      toExecute: () {
        _minValueController.save();
      },
    );
  }
  void saveMaxValue() {
    return _excuteThenNotifyListeners(
      toExecute: () {
        _maxValueController.save();
      },
    );
  }

  bool validateMinValue() {
    return _excuteThenNotifyListeners<bool>(
      toExecute: () {
        return _minValueController.validate();
      },
    );
  }

  bool validateMaxValue() {
    return _excuteThenNotifyListeners<bool>(
      toExecute: () {
        return _maxValueController.validate();
      },
    );
  }

  @override
  bool validate() {
    return _excuteThenNotifyListeners<bool>(
      toExecute: () {
        bool isValidMin = _minValueController.validate();
        bool isValidMax = _maxValueController.validate();
        return isValidMin && isValidMax;
      },
    );
  }

  R _excuteThenNotifyListeners<R>({
    required R Function() toExecute,
  }) {
    final result = toExecute();
    notifyListeners();
    return result;
  }

  @override
  void dispose() {
    _minValueController.dispose();
    _maxValueController.dispose();
    super.dispose();
  }
  
}
