import 'package:flutter/material.dart';
import '../../../foo_form_field.dart';
import '../../common/models/controlled_field_state.dart';

class MultiSelectionFormField<Entity extends Object> extends StatelessWidget {
  
  final BaseMultiSelectionFieldController<Entity> controller;
  final Widget Function(BuildContext context, int index , Entity item) itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final FooFormFieldProperties<List<Entity>>? properties;
  final InputDecoration? decoration;
  final void Function(BuildContext context) onTap;
  final Widget Function(BuildContext context, ControlledFieldState<List<Entity>, List<Entity>> controlledFieldState)? builder;

  const MultiSelectionFormField({
    super.key,
    required this.itemBuilder,
    required this.controller,
    required this.onTap,
    this.builder, 
    this.properties, 
    this.decoration, 
    this.separatorBuilder,
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

  Widget _builder(BuildContext context, ControlledFieldState<List<Entity>, List<Entity>> controlledFieldState){
    if (builder!=null) {
      return builder!.call(context,controlledFieldState);
    }

    final selectedItems = controller.value??[];
    final selectedItemWidgets = <Widget>[];
    for (var i = 0; i < selectedItems.length; i++) {
      selectedItemWidgets.add(itemBuilder(context, i, selectedItems[i]));
    }

    return SelectionButton(
      onTap: () => onTap(context), 
      selectedItems: selectedItemWidgets, 
      separatorBuilder: separatorBuilder,
    );
  }

}

