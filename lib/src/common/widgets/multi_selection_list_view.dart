import 'dart:async';
import 'package:flutter/material.dart';
import '../../controllers/multi_selection_field_controller.dart';
import '../models/selection_list_view_properties.dart';
import 'custom_checkbox.dart';
import 'selection_list_view.dart';

class MultiSelectionListView<Value> extends StatelessWidget {

  final BaseMultiSelectionFieldController<Value> controller;
  final Widget Function(BuildContext context, int index) itemBuilder;

  final FutureOr<void> Function(BuildContext context)? get;
  final FutureOr<void> Function(BuildContext context)? getMore;

  final Widget Function(BuildContext context, int index)? selectionButtonBuilder;
  final Widget Function(BuildContext context, int index, Widget selectionButton, Widget itemWidget)? itemLayoutBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Widget? emptyListWidget;
  final Widget? loadingWidgetBuilder;
  final Widget? paginationIndicatorWidget;
  final Widget Function(BuildContext context, String errorMessage)? errorWidgetBuilder;
  final SelectionListViewProperties? properties;

  const MultiSelectionListView._({
    super.key,
    required this.controller,
    required this.itemBuilder,
    required this.selectionButtonBuilder,
    required this.itemLayoutBuilder,
    required this.separatorBuilder,
    required this.emptyListWidget,
    required this.loadingWidgetBuilder,
    required this.paginationIndicatorWidget,
    required this.errorWidgetBuilder,
    required this.properties,
    required this.get,
    required this.getMore,
  });

  factory MultiSelectionListView({
    required MultiSelectionFieldController<Value> controller,
    required Widget Function(BuildContext context, int index) itemBuilder,
    Widget Function(BuildContext context, int index)? selectionButtonBuilder,
    Widget Function(BuildContext context, int index, Widget selectionButton, Widget itemWidget)? itemLayoutBuilder,
    Widget Function(BuildContext context, int index)? separatorBuilder,
    Widget? emptyListWidget,
    Widget? loadingWidgetBuilder,
    Widget Function(BuildContext context, String errorMessage)? errorWidgetBuilder,
    SelectionListViewProperties? properties,
  }) => MultiSelectionListView._(
    controller: controller,
    itemBuilder: itemBuilder,
    selectionButtonBuilder: selectionButtonBuilder,
    itemLayoutBuilder: itemLayoutBuilder,
    separatorBuilder: separatorBuilder,
    emptyListWidget: emptyListWidget,
    loadingWidgetBuilder: loadingWidgetBuilder,
    errorWidgetBuilder: errorWidgetBuilder,
    properties: properties,
    paginationIndicatorWidget: null,
    get: null,
    getMore: null,
  );

  factory MultiSelectionListView.getOnce({
    required GetOnceMultiSelectionFieldController<Value> controller,
    required Widget Function(BuildContext context, int index) itemBuilder,
    required FutureOr<void> Function(BuildContext context) get,
    Widget Function(BuildContext context, int index)? selectionButtonBuilder,
    Widget Function(BuildContext context, int index, Widget selectionButton, Widget itemWidget)? itemLayoutBuilder,
    Widget Function(BuildContext context, int index)? separatorBuilder,
    Widget? emptyListWidget,
    Widget? loadingWidgetBuilder,
    Widget Function(BuildContext context, String errorMessage)? errorWidgetBuilder,
    SelectionListViewProperties? properties,
  }) => MultiSelectionListView._(
    controller: controller,
    itemBuilder: itemBuilder,
    selectionButtonBuilder: selectionButtonBuilder,
    itemLayoutBuilder: itemLayoutBuilder,
    separatorBuilder: separatorBuilder,
    emptyListWidget: emptyListWidget,
    loadingWidgetBuilder: loadingWidgetBuilder,
    errorWidgetBuilder: errorWidgetBuilder,
    properties: properties,
    paginationIndicatorWidget: null,
    get: get,
    getMore: null,
  );

  factory MultiSelectionListView.paginated({
    required PaginatedMultiSelectionFieldController<Value> controller,
    required FutureOr<void> Function(BuildContext context) get,
    required FutureOr<void> Function(BuildContext context) getMore,
    required Widget Function(BuildContext context, int index) itemBuilder,
    Widget Function(BuildContext context, int index)? selectionButtonBuilder,
    Widget Function(BuildContext context, int index, Widget selectionButton, Widget itemWidget)? itemLayoutBuilder,
    Widget Function(BuildContext context, int index)? separatorBuilder,
    Widget? emptyListWidget,
    Widget? loadingWidgetBuilder,
    Widget? paginationIndicatorWidget,
    Widget Function(BuildContext context, String errorMessage)? errorWidgetBuilder,
    SelectionListViewProperties? properties,
  }) => MultiSelectionListView._(
    controller: controller,
    itemBuilder: itemBuilder,
    selectionButtonBuilder: selectionButtonBuilder,
    itemLayoutBuilder: itemLayoutBuilder,
    separatorBuilder: separatorBuilder,
    emptyListWidget: emptyListWidget,
    loadingWidgetBuilder: loadingWidgetBuilder,
    paginationIndicatorWidget: paginationIndicatorWidget,
    errorWidgetBuilder: errorWidgetBuilder,
    properties: properties,
    get: get,
    getMore: getMore,
  );

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

