import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foo_form_field/foo_form_field.dart';

import '../cubits/get_products_cubit.dart';
import '../models/product.dart';
import '../widgets/example_screen.dart';

class GetPaginatedSingleSelectionFormFieldExample extends StatefulWidget {
  const GetPaginatedSingleSelectionFormFieldExample({super.key});

  @override
  State<GetPaginatedSingleSelectionFormFieldExample> createState() =>
      _GetPaginatedSingleSelectionFormFieldExampleState();
}

class _GetPaginatedSingleSelectionFormFieldExampleState
    extends State<GetPaginatedSingleSelectionFormFieldExample> {
  late final PaginatedSingleSelectionFieldController<Product> _controller;
  late final GetProductsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = GetProductsCubit();
    _controller = PaginatedSingleSelectionFieldController<Product>(
      areEqual: (a, b) => a.id == b.id,
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
      child: BlocListener<GetProductsCubit, GetProductsState>(
        listener: (context, state) {
          if (state is GetProductsSuccess) {
            // Use setItems in all cases since cubit sends the complete list
            _controller.setItems(
              newItems: state.products,
              hasMore: state.hasMore,
            );
          } else if (state is GetProductsFailed) {
            _controller.markAsFailed(message: state.message);
          } else if (state is GetProductsLoading) {
            if (_controller.items.isEmpty) {
              // Only mark as loading if it's the first page
              _controller.markAsLoading();
            }
            // For pagination, the loading indicator is handled by paginationIndicatorWidget
          }
        },
        child: ExampleScreen(
          title: "Get Paginated Single Selection Form Field",
          fieldBuilder: () => SingleSelectionFormField<Product>(
            itemBuilder: (item) => Text('${item.name} - \$${item.price.toStringAsFixed(2)}'),
            controller: _controller,
            onTap: (context) {
              showModalBottomSheet(
                context: context,
                builder: (context) => SelectionBottomSheet.singleSelection(
                  controller: _controller,
                  selectionListView: SingleSelectionListView.paginated(
                    controller: _controller,
                    itemBuilder: (context, index) => Text(
                      '${_controller.items[index].name} - \$${_controller.items[index].price.toStringAsFixed(2)}',
                    ),
                    get: (context) => _cubit.getProducts(),
                    getMore: (context) => _cubit.getMoreProducts(),
                  ),
                ),
              );
            },
            properties: FooFormFieldProperties(
              validator: (value) => value == null ? "Value is required" : null,
              onChanged: (value) => log("Value Changed To: $value"),
              onSaved: (value) => log("Value Saved: $value"),
            ),
          ),
          children: [],
        ),
      ),
    );
  }
}

