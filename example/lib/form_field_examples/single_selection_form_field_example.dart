import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

import '../widgets/controller_test_buttons.dart';
import '../widgets/example_screen.dart';
enum SellingOrderStatus {
  pending,
  approved,
  rejected,
  cancelled,
  completed,
  refunded,
  returned,
  lost,
  damaged,
  other,  
  pendingPayment,
  pendingApproval,
  pendingFulfillment,
  pendingShipment,
  pendingDelivery,
  pendingConfirmation,
}


class SingleSelectionFormFieldExample extends StatefulWidget {
  const SingleSelectionFormFieldExample({super.key});

  @override
  State<SingleSelectionFormFieldExample> createState() => _SingleSelectionFormFieldExampleState();
}

class _SingleSelectionFormFieldExampleState extends State<SingleSelectionFormFieldExample> {
  final _controller = SingleSelectionFieldController<SellingOrderStatus>(
    initialValue: SellingOrderStatus.approved,
    areEqual: (a, b) => a == b,
    items: SellingOrderStatus.values,
  );

  @override
  Widget build(BuildContext context) {
    return ExampleScreen(
      title: "Single Selection Form Field",
      fieldBuilder: () => SingleSelectionFormField<SellingOrderStatus>(
        itemBuilder: (context,item) => Text(item.name),
        controller: _controller,
        decoration: InputDecoration(
          label: Text("Selling Order Status"),
        ),
        onTap: (context) {
          showSingleSelectionBottomSheet(
            context: context,
            selectionListView: SingleSelectionListView(
              controller: _controller,
              itemBuilder: (context,index) => Text(_controller.items[index].name),
            ),
          );
        },
        properties: FooFormFieldProperties(
          validator: (value) => value == null ? "Value is required" : null,
          onChanged: (value) => log("Value Changed To: $value"),
          onSaved: (value) => log("Value Saved: $value"),
        ),
      ),
      children: [
        ControllerTestButtons(
          title: "Single Selection Controller Test Buttons",
          controller: _controller,
          firstDummyValue: SellingOrderStatus.pending,
          secondDummyValue: SellingOrderStatus.approved,
          valueToString: (value) => value.name,
        ),
      ],
    );
  }
}