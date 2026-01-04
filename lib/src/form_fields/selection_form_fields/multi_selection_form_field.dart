import 'package:flutter/material.dart';
import '../../../foo_form_field.dart';
import '../../controllers/multi_selection_field_controller.dart';

class MultiSelectionFormField<Entity extends Object> extends StatelessWidget {
  
  final BaseMultiSelectionFieldController<Entity> controller;
  final Widget Function(BuildContext context, Entity item) itemBuilder;
  final FooFormFieldProperties<List<Entity>>? properties;
  final InputDecoration? decoration;
  final void Function(BuildContext context) onTap;
  final Widget Function(BuildContext context, List<Entity>? value)? builder;

  const MultiSelectionFormField({
    super.key,
    required this.itemBuilder,
    required this.controller,
    required this.onTap,
    this.builder, 
    this.properties, 
    this.decoration, 
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedValueFormField(
      controller: controller, 
      onTap: onTap, 
      decoration: decoration, 
      builder: _builder,
      properties: properties,
    );
  }

  Widget _builder(BuildContext context, List<Entity>? value){
    if (builder!=null) {
      return builder!.call(context,value);
    }

    final selectedItems = value?.map((item) => itemBuilder(context, item)).toList() ?? [];

    return SelectionButton(
      onTap: () => onTap(context),
      remainingWidgetBuilder: (remainingItemsCount) {
        return Text("+ $remainingItemsCount");
      },
      selectedItems: selectedItems,
    );
  }

}

