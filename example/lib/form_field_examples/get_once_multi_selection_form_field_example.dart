import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foo_form_field/foo_form_field.dart';

import '../cubits/get_suppliers_cubit.dart';
import '../models/supplier.dart';
import '../widgets/controller_test_buttons.dart';
import '../widgets/example_screen.dart';

class GetOnceMultiSelectionFormFieldExample extends StatefulWidget {
  const GetOnceMultiSelectionFormFieldExample({super.key});

  @override
  State<GetOnceMultiSelectionFormFieldExample> createState() =>
      _GetOnceMultiSelectionFormFieldExampleState();
}

class _GetOnceMultiSelectionFormFieldExampleState
    extends State<GetOnceMultiSelectionFormFieldExample> {
  late final GetOnceMultiSelectionFieldController<Supplier> _controller;
  late final GetSuppliersCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = GetSuppliersCubit();
    _controller = GetOnceMultiSelectionFieldController<Supplier>(
      areEqualValues: (a, b) => a.id == b.id,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocListener<GetSuppliersCubit, GetSuppliersState>(
        listener: (context, state) {
          if (state is GetSuppliersSuccess) {
            _controller.setItems(newItems: state.suppliers);
          } else if (state is GetSuppliersFailed) {
            _controller.markAsFailed(message: state.message);
          }else if (state is GetSuppliersLoading) {
            _controller.markAsLoading();
          }
        },
        child: ExampleScreen(
          title: "Get Once Multi Selection Form Field",
          fieldBuilder: () => MultiSelectionFormField<Supplier>(
            itemBuilder: (context, item) => Text('${item.name} (${item.email})'),
            controller: _controller,
            onTap: (context) {
              showMultiSelectionBottomSheet(
                context: context,
                selectionListView: MultiSelectionListView.getOnce(
                  controller: _controller,
                  itemBuilder: (context, index) => Text(
                    '${_controller.items[index].name} (${_controller.items[index].email})',
                  ),
                  get: (context) => _cubit.getSuppliers(),
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
              title: "Get Once Multi Selection Controller Test Buttons",
              controller: _controller,
              firstDummyValue: [
                Supplier(id: 1, name: "Supplier 1", email: "supplier1@example.com"),
                Supplier(id: 2, name: "Supplier 2", email: "supplier2@example.com"),
              ],
              secondDummyValue: [
                Supplier(id: 3, name: "Supplier 3", email: "supplier3@example.com"),
                Supplier(id: 4, name: "Supplier 4", email: "supplier4@example.com"),
              ],
              valueToString: (value) => value.map((e) => e.name).join(", "),
            ),
          ],
        ),
      ),
    );
  }
}

