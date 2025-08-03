
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:thrift_store/app/constant/api/api_endpoints.dart';
// import 'package:thrift_store/features/cart/presentation/view_model/cart_bloc.dart';
// import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';



// class SingleProductView extends StatefulWidget {
//   final ProductEntity product;
//   const SingleProductView({Key? key, required this.product}) : super(key: key);

//   @override
//   State<SingleProductView> createState() => _SingleProductViewState();
// }

// class _SingleProductViewState extends State<SingleProductView> {
//   int quantity = 1;

//   @override
//   Widget build(BuildContext context) {
//     final product = widget.product;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product Details'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product image with rounded border
//             Center(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 child: Image.network(
//                   "${ApiEndpoints.imageUrl}${product.imageUrl}",
//                   height: 250,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       height: 250,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         color: Colors.grey[200],
//                       ),
//                       child: const Icon(Icons.error, size: 50),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Product name and stock
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     product.name,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   decoration: BoxDecoration(
//                     color: Colors.orangeAccent.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Text(
//                     "Stock: ${product.stock}",
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.orangeAccent,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),

//             // Price
//             Text(
//               'Rs. ${product.price}',
//               style: const TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Quantity Selector
//             Row(
//               children: [
//                 const Text(
//                   "Quantity:",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(width: 10),
//                 IconButton(
//                   icon: const Icon(Icons.remove_circle_outline, color: Colors.black),
//                   onPressed: () {
//                     if (quantity > 1) {
//                       setState(() {
//                         quantity--;
//                       });
//                     }
//                   },
//                 ),
//                 Text(
//                   quantity.toString(),
//                   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.add_box, color: Colors.black),
//                   onPressed: () {
//                     setState(() {
//                       quantity++;
//                     });
//                   },
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),

//             // Add to Cart Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   context.read<CartBloc>().add(AddProductToCartEvent(
//                     productId: product.productId ?? '',
//                     userId: 'sush123',
//                     productName: product.name,
//                     productPrice: product.price.toDouble(),
//                     productQuantity: quantity,
//                   ));

//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Product added to cart!")),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black,
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//                 child: const Text(
//                   "Add to Cart",
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 25),

//             // Description
//             Text(
//               product.condition,
//               style: const TextStyle(fontSize: 16, color: Colors.black87),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
