import 'dart:async';

import 'package:flutter/material.dart';

import '../../controllers/selection_field_controller.dart';
import '../models/selection_list_view_properties.dart';

class SelectionListView<SelectionController extends SelectionFieldController> extends StatefulWidget {
  const SelectionListView({
    super.key, 
    required this.controller,
  });

  final SelectionController controller;

  final void Function(int index)? onSelectionChanged;

  final FutureOr<void> Function(BuildContext context)? get;
  final FutureOr<void> Function(BuildContext context)? getMore;

  final Widget? Function(BuildContext context, int index) itemBuilder;
  final Widget? Function(BuildContext context, int index) selectionButtonBuilder;
  final Widget? Function(BuildContext context, int index) itemLayoutBuilder;


  final Widget? loadingWidgetBuilder;
  final Widget? paginationIndicatorWidget;
  final Widget Function(BuildContext context,String errorMessage)? errorWidgetBuilder;

  final SelectionListViewProperties? properties;

  @override
  State<SelectionListView> createState() => _SelectionListViewState();
}

class _SelectionListViewState extends State<SelectionListView> {

  late final ScrollController _scrollController;
  
  List _items => widget.controller.items;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.properties?.controller ?? ScrollController();
    widget.controller.addListener(_onScrollChanged);
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
    if (widget.) {
      
    }
    return ListView.separated(
      itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount);
  }

  void _onScrollChanged() {
    if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
      widget.getMore?.call(context);
    }
  }

}