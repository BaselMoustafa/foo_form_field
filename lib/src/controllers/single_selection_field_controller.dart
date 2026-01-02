import 'selection_field_controller.dart';

abstract class BaseSingleSelectionFieldController<Value> extends SelectionFieldController<Value,Value> {
  
  BaseSingleSelectionFieldController({
    required super.items,
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    required super.areEqual,
  });
  
}

class SingleSelectionFieldController<Value> extends BaseSingleSelectionFieldController<Value> {
  
  SingleSelectionFieldController({
    required super.items,
    required super.areEqual,
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  });

}

class GetOnceSingleSelectionFieldController<Value> 
  extends _StateManagementSingleSelectionFieldController<Value> with GetOnceStateManagementMixin<Value,Value> {

  GetOnceSingleSelectionFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    required super.areEqual,
  });

}

class PaginatedSingleSelectionFieldController<Value> 
  extends _StateManagementSingleSelectionFieldController<Value> with PaginationStateManagementMixin<Value,Value> {

  PaginatedSingleSelectionFieldController({
    required super.areEqual,
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  });
}

abstract class _StateManagementSingleSelectionFieldController<Value> 
  extends BaseSingleSelectionFieldController<Value> with GetStateManagementMixin<Value,Value> {
  
  _StateManagementSingleSelectionFieldController({
    required super.areEqual,
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }) : super(items: []);
}
