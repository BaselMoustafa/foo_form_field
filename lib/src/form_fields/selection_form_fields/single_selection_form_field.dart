
import 'package:flutter/material.dart';
import '../../../foo_form_field.dart';
class SingleSelectionFormField<Entity extends Object> extends StatelessWidget {
  
  final BaseSingleSelectionFieldController<Entity> controller;
  final Widget Function(BuildContext context, Entity item) itemBuilder;
  final FooFormFieldProperties<Entity>? properties;
  final InputDecoration? decoration;
  final void Function(BuildContext context) onTap;
  final Widget Function(BuildContext context, Entity? value)? builder;

  const SingleSelectionFormField({
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

  Widget _builder(BuildContext context, Entity? value){
    if (builder!=null) {
      return builder!.call(context,value);
    }

    return SelectionButton(
      onTap: () => onTap(context),
      remainingWidgetBuilder: (remainingItemsCount) {
        return Text("+ $remainingItemsCount");
      },
      selectedItems:controller.value==null?[]:[itemBuilder(context, controller.value as Entity)],
    );
  }

}