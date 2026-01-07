import 'dart:async';
import 'package:flutter/material.dart';
import '../../controllers/multi_selection_field_controller.dart';
import '../models/selection_list_view_properties.dart';
import 'custom_checkbox.dart';
import 'selection_list_view.dart';

abstract class BaseMultiSelectionListView<Value> extends StatelessWidget {
  final BaseMultiSelectionFieldController<Value> controller;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index)? selectionButtonBuilder;
  final Widget Function(BuildContext context, int index, Widget selectionButton, Widget itemWidget)? itemLayoutBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Widget? emptyListWidget;
  final Widget? loadingWidgetBuilder;
  final Widget? paginationIndicatorWidget;
  final Widget Function(BuildContext context, String errorMessage)? errorWidgetBuilder;
  final SelectionListViewProperties? properties;
  final FutureOr<void> Function(BuildContext context)? get;
  final FutureOr<void> Function(BuildContext context)? getMore;

  const BaseMultiSelectionListView({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.selectionButtonBuilder,
    this.itemLayoutBuilder,
    this.separatorBuilder,
    this.emptyListWidget,
    this.loadingWidgetBuilder,
    this.paginationIndicatorWidget,
    this.errorWidgetBuilder,
    this.properties,
    this.get,
    this.getMore,
  });

  @override
  Widget build(BuildContext context) {
    return SelectionListView(
      controller: controller, 
      get: get, 
      getMore: getMore, 
      itemBuilder: itemBuilder, 
      selectionButtonBuilder: _selectionButtonBuilder, 
      itemLayoutBuilder: _itemLayoutBuilder, 
      separatorBuilder: separatorBuilder, 
      emptyListWidget: emptyListWidget, 
      loadingWidgetBuilder: loadingWidgetBuilder, 
      paginationIndicatorWidget: paginationIndicatorWidget, 
      errorWidgetBuilder: errorWidgetBuilder, 
      properties: properties, 
    );
  }

  Widget _itemLayoutBuilder(BuildContext context, int index, Widget selectionButton, Widget itemWidget){
    if(itemLayoutBuilder!=null){
      return itemLayoutBuilder!(context, index, selectionButton, itemWidget);
    }

    return InkWell(
      onTap: ()=>controller.toggleSelectionFor(
        controller.items[index],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          spacing: 10,
          children: [
            selectionButton,
            itemWidget,
          ],
        ),
      ),
    );
  }

  Widget _selectionButtonBuilder(BuildContext context, int index){
    if(selectionButtonBuilder!=null){
      return selectionButtonBuilder!(context, index);
    }

    bool isSelected = controller.isSelected(controller.items[index]);
    
    return CustomCheckbox(
      isSelected: isSelected,
      onTap: (_)=>controller.toggleSelectionFor(
        controller.items[index],
      ),
    );
  }
}

class MultiSelectionListView<Value> extends BaseMultiSelectionListView<Value> {
  const MultiSelectionListView({
    super.key,
    required MultiSelectionFieldController<Value> controller,
    required super.itemBuilder,
    super.selectionButtonBuilder,
    super.itemLayoutBuilder,
    super.separatorBuilder,
    super.emptyListWidget,
    super.loadingWidgetBuilder,
    super.errorWidgetBuilder,
    super.properties,
  }) : super(
    controller: controller,
    get: null,
    getMore: null,
    paginationIndicatorWidget: null,
  );
}

class GetOnceMultiSelectionListView<Value> extends BaseMultiSelectionListView<Value> {
  const GetOnceMultiSelectionListView({
    super.key,
    required GetOnceMultiSelectionFieldController<Value> controller,
    required super.itemBuilder,
    required FutureOr<void> Function(BuildContext context) get,
    super.selectionButtonBuilder,
    super.itemLayoutBuilder,
    super.separatorBuilder,
    super.emptyListWidget,
    super.loadingWidgetBuilder,
    super.errorWidgetBuilder,
    super.properties,
  }) : super(
    controller: controller,
    get: get,
    getMore: null,
    paginationIndicatorWidget: null,
  );
}

class PaginatedMultiSelectionListView<Value> extends BaseMultiSelectionListView<Value> {
  const PaginatedMultiSelectionListView({
    super.key,
    required PaginatedMultiSelectionFieldController<Value> controller,
    required super.itemBuilder,
    required FutureOr<void> Function(BuildContext context) get,
    required FutureOr<void> Function(BuildContext context) getMore,
    super.selectionButtonBuilder,
    super.itemLayoutBuilder,
    super.separatorBuilder,
    super.emptyListWidget,
    super.loadingWidgetBuilder,
    super.paginationIndicatorWidget,
    super.errorWidgetBuilder,
    super.properties,
  }) : super(
    controller: controller,
    get: get,
    getMore: getMore,
  );
}
