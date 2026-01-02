import 'selection_field_controller.dart';

abstract class BaseMultiSelectionFieldController<Value> extends SelectionFieldController<List<Value>,Value> {
  
  BaseMultiSelectionFieldController({
    required super.items,
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    required super.areEqual,
  });
  
}

class MultiSelectionFieldController<Value> extends BaseMultiSelectionFieldController<Value> {
  
  MultiSelectionFieldController({
    required super.items,
    required super.areEqual,
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  });

}

class GetOnceMultiSelectionFieldController<Value> 
  extends _StateManagementMultiSelectionFieldController<Value> with GetOnceStateManagementMixin<List<Value>,Value> {

  GetOnceMultiSelectionFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    required super.areEqual,
  });

}

class PaginatedMultiSelectionFieldController<Value> 
  extends _StateManagementMultiSelectionFieldController<Value> with PaginationStateManagementMixin<List<Value>,Value> {

  PaginatedMultiSelectionFieldController({
    required super.areEqual,
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  });
}

abstract class _StateManagementMultiSelectionFieldController<Value> 
  extends BaseMultiSelectionFieldController<Value> with GetStateManagementMixin<List<Value>,Value> {
  
  _StateManagementMultiSelectionFieldController({
    required super.areEqual,
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }) : super(items: []);
}
