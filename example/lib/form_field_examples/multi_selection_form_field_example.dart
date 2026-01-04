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


class MultiSelectionFormFieldExample extends StatefulWidget {
  const MultiSelectionFormFieldExample({super.key});

  @override
  State<MultiSelectionFormFieldExample> createState() => _MultiSelectionFormFieldExampleState();
}

class _MultiSelectionFormFieldExampleState extends State<MultiSelectionFormFieldExample> {
  final _controller = MultiSelectionFieldController<SellingOrderStatus>(
    initialValue: [SellingOrderStatus.approved, SellingOrderStatus.pending],
    areEqualValues: (a, b) => a == b,
    items: SellingOrderStatus.values,
  );

  @override
  Widget build(BuildContext context) {
    return ExampleScreen(
      title: "Multi Selection Form Field",
      fieldBuilder: () => MultiSelectionFormField<SellingOrderStatus>(
        itemBuilder: (context,item) => Text(item.name),
        controller: _controller,
        decoration: InputDecoration(
          label: Text("Selling Order Status"),
        ),
        onTap: (context) {
          showMultiSelectionBottomSheet(
            context: context,
            selectionListView: MultiSelectionListView(
              controller: _controller,
              itemBuilder: (context,index) => Text(_controller.items[index].name),
            ),
          );
        },
        properties: FooFormFieldProperties(
          validator: (value) => value == null || value.isEmpty ? "Value is required" : null,
          onChanged: (value) => log("Value Changed To: $value"),
          onSaved: (value) => log("Value Saved: $value"),
        ),
      ),
      children: [
        ControllerTestButtons(
          title: "Multi Selection Controller Test Buttons",
          controller: _controller,
          firstDummyValue: [SellingOrderStatus.pending, SellingOrderStatus.approved],
          secondDummyValue: [SellingOrderStatus.completed, SellingOrderStatus.refunded],
          valueToString: (value) => value.map((e) => e.name).join(", "),
        ),
      ],
    );
  }
}

