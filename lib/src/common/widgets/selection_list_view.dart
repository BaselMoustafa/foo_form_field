import 'dart:async';
import 'package:flutter/material.dart';

import '../../controllers/selection_field_controller.dart';
import '../get_items_state.dart';
import '../models/selection_list_view_properties.dart';
import 'loading_widget.dart';

class SelectionListView<SelectionController extends SelectionFieldController> extends StatefulWidget {
  const SelectionListView({
    super.key, 
    required this.controller,
    required this.get,
    required this.getMore,
    required this.itemBuilder,
    required this.selectionButtonBuilder,
    required this.itemLayoutBuilder,
    required this.separatorBuilder,
    required this.emptyListWidget,
    required this.loadingWidgetBuilder,
    required this.paginationIndicatorWidget,
    required this.errorWidgetBuilder,
    required this.properties,
  });

  final SelectionController controller;

  final FutureOr<void> Function(BuildContext context)? get;
  final FutureOr<void> Function(BuildContext context)? getMore;

  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index) selectionButtonBuilder;
  final Widget Function(BuildContext context, int index,Widget selectionButton, Widget itemWidget) itemLayoutBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  final Widget? emptyListWidget;


  final Widget? loadingWidgetBuilder;
  final Widget? paginationIndicatorWidget;
  final Widget Function(BuildContext context,String errorMessage)? errorWidgetBuilder;

  final SelectionListViewProperties? properties;

  @override
  State<SelectionListView> createState() => _SelectionListViewState();
}

class _SelectionListViewState extends State<SelectionListView> {

  late final ScrollController _scrollController;
  
  List get _items  => widget.controller.items;

  bool get _withPaginationIndicator{
    
    if (widget.controller is PaginationStateManagementMixin) {
      final controller = widget.controller as PaginationStateManagementMixin;
      if (controller.getItemsState is GetItemsStateSuccess) {
        final getItemsState = controller.getItemsState as GetItemsStateSuccess;
        if (getItemsState.hasMore) {
          return true;
        }
      }
    }
    return false;
  }

  int get _itemCount => _items.length + (_withPaginationIndicator ? 1 : 0);

  SelectionFieldController get _controller => widget.controller;

  SelectionListViewProperties get _properties => widget.properties ?? SelectionListViewProperties.defaultProperties();

  @override
  void initState() {
    super.initState();
    _scrollController = widget.properties?.controller ?? ScrollController();
    _scrollController.addListener(_onScrollChanged);
    widget.controller.addListener(_refresh);
    WidgetsBinding.instance.addPostFrameCallback(_afterFirstBuild);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollChanged);
    if (widget.properties?.controller==null) {
      _scrollController.dispose();
    }
    widget.controller.removeListener(_refresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller is GetStateManagementMixin) {
      final toDisplay = handleGetItemsState(
        (_controller as GetStateManagementMixin).getItemsState
      );
      
      if (toDisplay != null) {
        return toDisplay;
      }
    }

    if (_items.isEmpty) {
      return widget.emptyListWidget?? Text("No items found");
    }

    return ListView.separated(
      itemCount: _itemCount,
      itemBuilder: _itemBuilder, 
      separatorBuilder: _separatorBuilder, 
      addAutomaticKeepAlives: _properties.addAutomaticKeepAlives,
      addRepaintBoundaries: _properties.addRepaintBoundaries,
      addSemanticIndexes: _properties.addSemanticIndexes,
      cacheExtent: _properties.cacheExtent,
      dragStartBehavior: _properties.dragStartBehavior,
      keyboardDismissBehavior: _properties.keyboardDismissBehavior,
      restorationId: _properties.restorationId,
      clipBehavior: _properties.clipBehavior,
      hitTestBehavior: _properties.hitTestBehavior,
      controller: _scrollController,
      scrollDirection: _properties.scrollDirection,
      reverse: _properties.reverse,
      primary: _properties.primary,
      physics: _properties.physics,
      shrinkWrap: _properties.shrinkWrap,
      padding: _properties.padding,
      findChildIndexCallback: _properties.findChildIndexCallback,
    );
  }

  Widget? handleGetItemsState(GetItemsState getItemsState) {
    if (getItemsState is GetItemsStateInitial) {
      return Text(
        "You have not initialized the selection list view yet and this is not supposed to happen !!!!",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
        ),
      );
    }

    else if (getItemsState is GetItemsStateLoading) {
      return widget.loadingWidgetBuilder ?? LoadingWidget();
    }

    else if (getItemsState is GetItemsStateFailed) {
      final errorMessage = getItemsState.message;

      return widget.errorWidgetBuilder?.call(
        context, errorMessage
      )?? Column(
        children: [
          Text(errorMessage),

          ElevatedButton(
            onPressed: () {
              widget.get?.call(context);
            },
            child: Text("Retry"),
          ),
        ],
      );
    }
    return null;
  }

  void _refresh() {
    setState(() {});
  }

  void _afterFirstBuild(Duration _) {
    widget.controller.initForSelection();
    if (_controller is GetStateManagementMixin) {
      final controller = _controller as GetStateManagementMixin;
      final getItemsState = controller.getItemsState;
      if (getItemsState is GetItemsStateInitial) {
        widget.get?.call(context);
      }
    }
  }

  void _onScrollChanged() {
    if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
      widget.getMore?.call(context);
    }
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (index == _items.length) {
      return widget.paginationIndicatorWidget ?? LoadingWidget();
    }

    final selectionButton = widget.selectionButtonBuilder(context, index);
    final itemWidget = widget.itemBuilder(context, index);

    return widget.itemLayoutBuilder.call(context, index, selectionButton, itemWidget) ;
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    if (index == _items.length-1) {
      return const SizedBox(height: 10);
    }

     if(widget.separatorBuilder!=null){
      return widget.separatorBuilder!(context, index);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Divider(
        height: 1,
        color: Colors.grey.shade500,
      ),
    );
  }
}
