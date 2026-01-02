import 'package:flutter/material.dart';

class SelectionButton extends StatefulWidget {
  const SelectionButton({
    super.key,
    required this.selectedItems,
    required this.onTap,
    required this.remainingWidgetBuilder,
    this.maxLines = 1,
    this.spacing = 8,
    this.runSpacing = 8,
  });

  final int maxLines;
  final double spacing;
  final double runSpacing;
  final List<Widget> selectedItems;
  final VoidCallback onTap;
  final Widget Function(int remainingItemsCount) remainingWidgetBuilder;

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  final ValueNotifier<int> _remainingCount = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.selectedItems,
    );
  }

  @override
  void dispose() {
    _remainingCount.dispose();
    super.dispose();
  }
}
