import 'package:flutter/material.dart';
import '../../../foo_form_field.dart';

class MultiSelectionFormField<Entity extends Object> extends StatelessWidget {
  
  final BaseMultiSelectionFieldController<Entity> controller;
  final Widget Function(BuildContext context, int index , Entity item) itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final FooFormFieldProperties<List<Entity>>? properties;
  final DecorationBuilder<List<Entity>>? decorationBuilder;
  final void Function(BuildContext context) onTap;
  final FooFormFieldBuilder<List<Entity>>? builder;
  final FooFormFieldStateProvider<List<Entity>>? stateProvider;

  const MultiSelectionFormField({
    super.key,
    required this.itemBuilder,
    required this.controller,
    required this.onTap,
    this.builder, 
    this.properties, 
    this.decorationBuilder,
    this.stateProvider,
    this.separatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedFormField(
      controller: controller, 
      onTap: onTap, 
      decorationBuilder: decorationBuilder, 
      builder: _builder,
      properties: properties,
      stateProvider: stateProvider,
    );
  }

  Widget _builder(BuildContext context, FooFormFieldState<List<Entity>> fieldState){
    if (builder!=null) {
      return builder!.call(context, fieldState);
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

