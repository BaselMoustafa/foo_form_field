import 'selection_field_controller.dart';

abstract class BaseSingleSelectionFieldController<Value> extends SelectionFieldController<Value,Value> {
  
  BaseSingleSelectionFieldController({
    required super.items,
    super.initialValue,
    required super.areEqual,
  });

  @override
  bool isSelected(Value value) {
    if (selectedValue == null) return false;
    return areEqual(value, selectedValue as Value);
  }

  @override
  void toggleSelectionFor(Value e) {
    if (isSelected(e)) {
      selectedValue = null;
    } else {
      selectedValue = e;
    }
  }

  @override
  void initForSelection() {
    selectedValue = value;
  }
}

class SingleSelectionFieldController<Value> extends BaseSingleSelectionFieldController<Value> {
  
  SingleSelectionFieldController({
    required super.items,
    required super.areEqual,
    super.initialValue,
  });

}

class GetOnceSingleSelectionFieldController<Value> 
  extends _StateManagementSingleSelectionFieldController<Value> with GetOnceStateManagementMixin<Value,Value> {

  GetOnceSingleSelectionFieldController({
    super.initialValue,
    required super.areEqual,
  });

}

class PaginatedSingleSelectionFieldController<Value> 
  extends _StateManagementSingleSelectionFieldController<Value> with PaginationStateManagementMixin<Value,Value> {

  PaginatedSingleSelectionFieldController({
    required super.areEqual,
    super.initialValue,
  });
}

abstract class _StateManagementSingleSelectionFieldController<Value> 
  extends BaseSingleSelectionFieldController<Value> with GetStateManagementMixin<Value,Value> {
  
  _StateManagementSingleSelectionFieldController({
    required super.areEqual,
    super.initialValue,
  }) : super(items: []);
}
