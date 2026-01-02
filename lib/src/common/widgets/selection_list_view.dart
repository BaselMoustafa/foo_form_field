import 'dart:async';

import 'package:flutter/material.dart';

import '../../controllers/selection_field_controller.dart';
import '../get_items_state.dart';
import '../models/selection_list_view_properties.dart';

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
    required this.onSelectionChanged,
  });

  final SelectionController controller;

  final void Function(int index)? onSelectionChanged;

  final FutureOr<void> Function(BuildContext context)? get;
  final FutureOr<void> Function(BuildContext context)? getMore;

  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index) selectionButtonBuilder;
  final Widget Function(BuildContext context, int index)? itemLayoutBuilder;
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

  bool get _withPaginationIndicator => widget.paginationIndicatorWidget != null;

  int get _itemCount => _items.length + (_withPaginationIndicator ? 1 : 0);

  SelectionFieldController get _controller => widget.controller;

  SelectionListViewProperties get _properties => widget.properties ?? SelectionListViewProperties.defaultProperties();

  @override
  void initState() {
    super.initState();
    _scrollController = widget.properties?.controller ?? ScrollController();
    widget.controller.addListener(_onScrollChanged);
    WidgetsBinding.instance.addPostFrameCallback(_afterFirstBuild);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScrollChanged);
    if (widget.properties?.controller==null) {
      _scrollController.dispose();
    }
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
    final controller = _controller as GetStateManagementMixin;
    final getItemsState = controller.getItemsState;

    if (getItemsState is GetItemsStateInitial) {
      return Text("You have not initialized the selection list view yet and this is not supposed to happen !!!!");
    }

    else if (getItemsState is GetItemsStateLoading) {
      return widget.loadingWidgetBuilder ?? CircularProgressIndicator();
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

  void _afterFirstBuild(Duration _) {
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
      return widget.paginationIndicatorWidget ?? CircularProgressIndicator();
    }

    return widget.itemLayoutBuilder?.call(context, index) 
      ?? Row(
        spacing: 5,
        children: [
          widget.itemBuilder(context, index),
          widget.selectionButtonBuilder(context, index),
        ],
      );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    if (index == _items.length) {
      return const SizedBox(height: 10);
    }

    return widget.separatorBuilder?.call(context, index) ?? const SizedBox(height: 10);
  }
}
