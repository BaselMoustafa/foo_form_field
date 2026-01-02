import 'package:flutter/material.dart';

import 'single_selection_list_view.dart';

class SelectionBottomSheet<Value> extends StatelessWidget {

  final Widget selectionListView;
  final Widget Function(BuildContext context, Widget selectionListView)? builder;

  const SelectionBottomSheet._({
    required this.builder,
    required this.selectionListView, 
  });

  static SelectionBottomSheet<Value> singleSelection<Value>({
    required SingleSelectionListView<Value> selectionListView,
    Widget Function(BuildContext context, Widget selectionListView)? builder,
  }) => SelectionBottomSheet._(
    selectionListView: selectionListView,
    builder: builder,
  );



  @override
  Widget build(BuildContext context) {
    if (builder != null) {
      return builder!(context, selectionListView);
    }

    return BottomSheet(
      onClosing: (){},
      builder: (BuildContext context) {
        return Expanded(
          child: selectionListView,
        );
      },
    );
  }
}