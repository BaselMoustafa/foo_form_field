import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import '../models/product.dart';

// States
abstract class GetProductsState {}

class GetProductsInitial extends GetProductsState {}

class GetProductsLoading extends GetProductsState {}

class GetProductsSuccess extends GetProductsState {
  final List<Product> products;
  final bool hasMore;

  GetProductsSuccess({
    required this.products,
    required this.hasMore,
  });
}

class GetProductsFailed extends GetProductsState {
  final String message;

  GetProductsFailed(this.message);
}

// Cubit
class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit() : super(GetProductsInitial());

  static const int _pageSize = 10;
  int _currentPage = 0;
  bool _hasMore = true;

  Future<void> getProducts() async {
    _currentPage = 0;
    _hasMore = true;
    emit(GetProductsLoading());

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate random failure (10% chance)
    if (DateTime.now().millisecond % 10 == 0) {
      emit(GetProductsFailed('Failed to load products. Please try again.'));
      return;
    }

    // Return first page of dummy products
    final products = _generateProductsForPage(0);

    emit(GetProductsSuccess(
      products: products,
      hasMore: _hasMore,
    ));
  }

  Future<void> getMoreProducts() async {
    final currentState = state;
    if (currentState is! GetProductsSuccess || !_hasMore) return;

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    _currentPage++;

    // Simulate random failure (5% chance for pagination)
    if (DateTime.now().millisecond % 20 == 0) {
      emit(GetProductsFailed('Failed to load more products. Please try again.'));
      return;
    }

    // Generate next page (only new products)
    final newProducts = _generateProductsForPage(_currentPage);
    final allProducts = [
      ...currentState.products,
      ...newProducts,
    ];

    emit(GetProductsSuccess(
      products: allProducts,
      hasMore: _hasMore,
    ));
  }

  List<Product> _generateProductsForPage(int page) {
    final startIndex = page * _pageSize;
    final endIndex = startIndex + _pageSize;
    final totalProducts = 35; // Total products available

    // Check if there are more pages
    _hasMore = endIndex < totalProducts;

    final products = List.generate(
      _hasMore ? _pageSize : (totalProducts - startIndex),
      (index) => Product(
        id: startIndex + index + 1,
        name: 'Product ${startIndex + index + 1}',
        price: (startIndex + index + 1) * 10.0,
        description: 'Description for Product ${startIndex + index + 1}',
      ),
    );

    return products;
  }
}

