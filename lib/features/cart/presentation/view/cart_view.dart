// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';
// import 'package:thrift_store/features/cart/presentation/view_model/bloc/cart_bloc.dart';
// import 'package:thrift_store/features/cart/presentation/view_model/bloc/cart_event.dart';
// import 'package:thrift_store/features/cart/presentation/view_model/bloc/cart_state.dart';
// import 'package:thrift_store/features/cart/presentation/view_model/cart_bloc.dart';

// class CartView extends StatelessWidget {
//   const CartView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Cart'),
//       ),
//       body: BlocProvider(
//         create: (_) => CartBloc()..add(FetchCartItemsEvent()),
//         child: BlocBuilder<CartBloc, CartState>(
//           builder: (context, state) {
//             if (state is CartLoadingState) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is CartLoadedState) {
//               final cartItems = state.cartItems;

//               if (cartItems.isEmpty) {
//                 return const Center(child: Text('Your cart is empty.'));
//               }

//               return ListView.builder(
//                 itemCount: cartItems.length,
//                 itemBuilder: (context, index) {
//                   final item = cartItems[index];
//                   return _buildCartItem(context, item);
//                 },
//               );
//             } else if (state is Error) {
//               return Center(child: Text(state.));
//             } else {
//               return const Center(child: Text("Unknown state"));
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildCartItem(BuildContext context, CartItemEntity item) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       child: ListTile(
//         leading: Image.network(
//           item.imageUrl ?? '',
//           width: 50,
//           errorBuilder: (context, _, __) => const Icon(Icons.image),
//         ),
//         title: Text(item.name),
//         subtitle: Text('Quantity: ${item.quantity}'),
//         trailing: IconButton(
//           icon: const Icon(Icons.delete_outline),
//           onPressed: () {
//             context.read<CartBloc>().add(RemoveFromCartEvent(item));
//           },
//         ),
//       ),
//     );
//   }
// }
