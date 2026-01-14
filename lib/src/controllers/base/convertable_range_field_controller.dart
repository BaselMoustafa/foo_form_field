
import '../../common/ranges/ranges.dart';
import 'foo_field_controller.dart';

class ConvertableRangeFieldController<
  Value extends Comparable, 
  FieldValue extends Comparable,
  BoundryController extends FooFieldController<Value, FieldValue>
> extends FooFieldController<Range<Value>, Range<FieldValue>> {
  
  final BoundryController minController;
  
  final BoundryController maxController;

  ConvertableRangeFieldController({
    required super.mapper,
    required this.minController,
    required this.maxController,
    super.enabled,
  }) : super(
      areEqual: (Range<Value> x, Range<Value> y) => x == y,
      initialValue: Range<Value>(
        min: minController.value,
        max: maxController.value,
      )
    );

  @override
  /// Enables or disables both bound controllers along with the base controller.
  set enabled(bool value) {
    minController.enabled = value;
    maxController.enabled = value;
    super.enabled = value;
  }
  
  /// Hooks listeners that keep the range and bounds in sync.
  void invokeSyncers() {
    addListener(_onRangeChanged);
    minController.addListener(_onMinValueChanged);
    maxController.addListener(_onMaxValueChanged);
  }

  /// Updates the bound controllers when the range value changes.
  void _onRangeChanged() {
    if (value?.min != minController.value) {
      minController.value = value?.min;
    }
    if (value?.max != maxController.value) {
      maxController.value = value?.max;
    }
  }

  /// Reflects minimum bound changes back into the overall range value.
  void _onMinValueChanged() {
    if (value?.min == minController.value) {
      return;
    }
    value = Range<Value>(
      min: minController.value,
      max: value?.max,
    );
  }

  /// Reflects maximum bound changes back into the overall range value.
  void _onMaxValueChanged() {
    if (value?.max == maxController.value) {
      return;
    }
    value = Range<Value>(
      min: value?.min,
      max: maxController.value,
    );
  }

  /// Removes the synchronization listeners.
  void _removeSyncers() {
    removeListener(_onRangeChanged);
    minController.removeListener(_onMinValueChanged);
    maxController.removeListener(_onMaxValueChanged);
  }

  @override
  /// Cleans up listeners and disposes the bound controllers.
  void dispose() {
    _removeSyncers();
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }
}
