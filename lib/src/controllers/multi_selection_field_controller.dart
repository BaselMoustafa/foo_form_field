import 'package:flutter/material.dart';

import 'selection_field_controller.dart';

abstract class BaseMultiSelectionFieldController<Entity> extends SelectionFieldController<List<Entity>,Entity> {
  
  final bool Function(Entity x, Entity y) areEqualValues;
  BaseMultiSelectionFieldController({
    required super.items,
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    required this.areEqualValues,
  }):super(
    areEqual: ( List<Entity> x, List<Entity> y) {
      if (x.length != y.length) return false;

      final visitedYIndices = <int>{};
      
      for (var i = 0; i < x.length; i++) {
        bool found = false;
        for (var j = 0; j < y.length; j++) {
          if (visitedYIndices.contains(j)) continue;
          if (areEqualValues(x[i], y[j])) {
            found = true;
            visitedYIndices.add(j);
            break;
          }
        }
        if (!found) return false;
      }

      return true;
    },
  );

  @override
  bool isSelected(Entity value) {
    if (selectedValue == null) return false;
    for (var item in selectedValue as List<Entity>) {
      if (areEqualValues(value, item)) return true;
    }
    return false;
  }

  bool areSelected(List<Entity> values) {
    if (selectedValue == null) return false;

    for (var i = 0; i < values.length; i++) {
      bool found = false;
      for (var j = 0; j < selectedValue!.length; j++) {
        if (areEqualValues(values[i], selectedValue![j])) {
          found = true;
          break;
        }
      }
      if (!found) return false;
    }
    return true;
  }

  @override
  void toggleSelectionFor(Entity e) {
    excute<void>(
      needToNotifyListener: true,
      toExecute: (FormFieldState<List<Entity>> formFieldState) {
        if (isSelected(e)) {
          selectedValue!.removeWhere(
            (item) => areEqualValues(item, e),
          );
        } else {
          if (selectedValue == null) {
            selectedValue = [e];
          } else {
            selectedValue!.add(e);
          }
        }
      },
    );
  }

  @override
  void initForSelection() {
    excute<void>(
      needToNotifyListener: true,
      toExecute: (FormFieldState<List<Entity>> formFieldState) {
        selectedValue = List.from(value ?? []);
      },
    );
  }
}

class MultiSelectionFieldController<Value> extends BaseMultiSelectionFieldController<Value> {
  
  MultiSelectionFieldController({
    required super.items,
    required super.areEqualValues,
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
    required super.areEqualValues,
  });

}

class PaginatedMultiSelectionFieldController<Value> 
  extends _StateManagementMultiSelectionFieldController<Value> with PaginationStateManagementMixin<List<Value>,Value> {

  PaginatedMultiSelectionFieldController({
    required super.areEqualValues,
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  });
}

abstract class _StateManagementMultiSelectionFieldController<Value> 
  extends BaseMultiSelectionFieldController<Value> with GetStateManagementMixin<List<Value>,Value> {
  
  _StateManagementMultiSelectionFieldController({
    required super.areEqualValues,
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }) : super(items: []);
}
