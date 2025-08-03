// lib/features/cart/presentation/pages/cart_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrift_store/features/bookings/presentation/view/booking_page.dart';
import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';
import 'package:thrift_store/features/cart/presentation/view_model/cart_bloc.dart';
import 'package:thrift_store/features/cart/presentation/view_model/cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      // Removed BlocListener for BookingBloc from here
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          }

          if (state.items.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }

          final total = state.items.fold<double>(
            0.0,
            (sum, item) => sum + ((item.price ?? 0.0) * item.quantity),
          );

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final CartItemEntity item = state.items[index];
                    return ListTile(
                      leading: const Icon(Icons.shopping_cart),
                      title: Text(item.productName ?? 'No Name'),
                      subtitle: Text('Price: ₹${item.price ?? 0}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              if (item.quantity > 1) {
                                context.read<CartBloc>().add(
                                      DecrementItemQuantityEvent(item
                                          .productId), // ✨ Use the correct event
                                    );
                              } else {
                                // Logic to remove the item completely if quantity is 1
                                context.read<CartBloc>().add(
                                    RemoveProductFromCartEvent(
                                        productId: item.productId));
                              }
                            },
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              context.read<CartBloc>().add(
                                    IncrementItemQuantityEvent(item.productId),
                                  );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("₹${total.toStringAsFixed(2)}",
                            style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to BookingPage, passing cart items and total
                              if (state.items.isNotEmpty) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BookingPage(
                                      cartItems: state.items,
                                      cartTotal: total,
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Your cart is empty.')),
                                );
                              }
                            },
                            child: const Text('Checkout'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(Icons.delete_forever,
                              color: Colors.red),
                          onPressed: () {
                            context.read<CartBloc>().add(ClearCartEvent());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
