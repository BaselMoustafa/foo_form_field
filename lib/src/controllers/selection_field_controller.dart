import 'package:flutter/material.dart';

import '../../foo_form_field.dart';
import '../common/get_items_state.dart';

/// Abstract base class for selection field controllers.
/// 
/// This class provides the basic functionality for managing a selected value
/// that can be committed to the underlying field value.
abstract class SelectionFieldController<SelectedValue,Entity> extends ValueFieldController<SelectedValue> {

  SelectedValue? _selectedValue;

  List<Entity> items = [];

  SelectionFieldController({
    required this.items,
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    required super.areEqual,
  });

  bool isSelected(Entity value);

  SelectedValue? get selectedValue => _selectedValue;

  void toggleSelectionFor(Entity e);

  set selectedValue(SelectedValue? newSelectedValue) {
    _selectedValue = newSelectedValue;
    notifyListeners();
  }

  /// Commits the current selected value to the field value,
  /// then resets the selected value to null.
  void commit() {
    excute<void>(
      needToNotifyListener: true,
      toExecute: (FormFieldState<SelectedValue> formFieldState) {
        value = _selectedValue;
        _selectedValue = null;
      },
    );
  }

  /// Initializes the selection by resetting the selected value to null.
  void initForSelection() {
    excute<void>(
      needToNotifyListener: true,
      toExecute: (FormFieldState<SelectedValue> formFieldState) {
        _selectedValue = value;
      },
    );
  }
}

mixin GetStateManagementMixin<SelectedValue,Entity> on SelectionFieldController<SelectedValue,Entity> {
  GetItemsState getItemsState = GetItemsStateInitial();

  void markAsLoading(){
    getItemsState = GetItemsStateLoading();
    notifyListeners();
  }

  void markAsFailed({
    required String message,
  }){
    getItemsState = GetItemsStateFailed(
      message: message,
    );
    notifyListeners();
  }
}

mixin GetOnceStateManagementMixin<SelectedValue,Entity> on GetStateManagementMixin<SelectedValue,Entity> {
  
  void setItems({
    required List<Entity> newItems,
  }){
    items = newItems;
    getItemsState = GetItemsStateSuccess(
      items: newItems,
      hasMore: false,
    );
    notifyListeners();
  }
}

mixin PaginationStateManagementMixin<SelectedValue,Entity> on GetStateManagementMixin<SelectedValue,Entity> {
  void setItems({
    required List<Entity> newItems,
    required bool hasMore,
  }){
    items = newItems;
    getItemsState = GetItemsStateSuccess(
      items: newItems,
      hasMore: hasMore,
    );
    notifyListeners();
  }

  void addItems({
    required List<Entity> newItems,
    required bool hasMore,
  }){
    items.addAll(newItems);
    getItemsState = GetItemsStateSuccess(
      items: items,
      hasMore: hasMore,
    );
    notifyListeners();
  }
}