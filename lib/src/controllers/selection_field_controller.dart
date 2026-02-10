
import 'package:flutter/material.dart';

import '../../foo_form_field.dart';
import '../common/get_items_state.dart';

/// Abstract base class for selection field controllers.
/// 
/// This class provides the basic functionality for managing a selected value
/// that can be committed to the underlying field value.
abstract class SelectionFieldController<SelectedValue,Entity> extends FooFieldController<SelectedValue> {

  late final selectedValueNotifier = ValueNotifier<SelectedValue?>(
    initialValue
  );

  List<Entity> items = [];

  SelectionFieldController({
    required this.items,
    super.initialValue,
    required super.areEqual,
  });

  bool isSelected(Entity value);

  /// Initializes the selection by resetting the selected value to null.
  void initForSelection();

  SelectedValue? get selectedValue => selectedValueNotifier.value;

  void toggleSelectionFor(Entity e);

  set selectedValue(SelectedValue? newSelectedValue) {
    selectedValueNotifier.value = newSelectedValue;
  }

  /// Commits the current selected value to the field value,
  /// then resets the selected value to null.
  void commit() {
    value = selectedValueNotifier.value;
  }

  @override
  void dispose() {
    selectedValueNotifier.dispose();
    super.dispose();
  }
}

mixin GetStateManagementMixin<SelectedValue,Entity> on SelectionFieldController<SelectedValue,Entity> {
  
  final getItemsStateNotifier = ValueNotifier<GetItemsState>(
    GetItemsStateInitial()
  );

  GetItemsState get getItemsState => getItemsStateNotifier.value;

  set getItemsState(GetItemsState newState){
    getItemsStateNotifier.value = newState;
  }

  void markAsLoading(){
    getItemsState = GetItemsStateLoading();
  }

  void markAsFailed({
    required String message,
  }){
    getItemsState = GetItemsStateFailed(
      message: message
    );
  }

  @override
  void dispose() {
    getItemsStateNotifier.dispose();
    super.dispose();
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