import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import '../models/supplier.dart';

// States
abstract class GetSuppliersState {}

class GetSuppliersInitial extends GetSuppliersState {}

class GetSuppliersLoading extends GetSuppliersState {}

class GetSuppliersSuccess extends GetSuppliersState {
  final List<Supplier> suppliers;

  GetSuppliersSuccess(this.suppliers);
}

class GetSuppliersFailed extends GetSuppliersState {
  final String message;

  GetSuppliersFailed(this.message);
}

// Cubit
class GetSuppliersCubit extends Cubit<GetSuppliersState> {
  GetSuppliersCubit() : super(GetSuppliersInitial());

  Future<void> getSuppliers() async {
    emit(GetSuppliersLoading());

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate random failure (10% chance)
    if (DateTime.now().second % 10 == 0 || DateTime.now().second % 5 == 0 || DateTime.now().second % 2 == 0) {
      emit(GetSuppliersFailed('Failed to load suppliers. Please try again.'));
      return;
    }

    // Return dummy suppliers
    final suppliers = List.generate(
      15,
      (index) => Supplier(
        id: index + 1,
        name: 'Supplier ${index + 1}',
        email: 'supplier${index + 1}@example.com',
      ),
    );

    emit(GetSuppliersSuccess(suppliers));
  }
}

