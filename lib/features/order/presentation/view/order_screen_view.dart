

// import 'package:flutter/material.dart';
// import 'package:thrift_store/app/constant/api/api_endpoints.dart';
// import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';


// class OrderScreenView extends StatefulWidget {
//   final List<CartItemEntity> cartItems;
//   final double totalPrice;

//   const OrderScreenView({
//     super.key,
//     required this.cartItems,
//     required this.totalPrice,
//   });

//   @override
//   State<OrderScreenView> createState() => _OrderScreenViewState();
// }

// class _OrderScreenViewState extends State<OrderScreenView> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _streetController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _provinceController = TextEditingController();
//   final TextEditingController _postCodeController = TextEditingController();
//   final TextEditingController _countryController = TextEditingController();

//   @override
//   void dispose() {
//     _streetController.dispose();
//     _cityController.dispose();
//     _provinceController.dispose();
//     _postCodeController.dispose();
//     _countryController.dispose();
//     super.dispose();
//   }

//   void _placeOrder() {
//     if (_formKey.currentState!.validate()) {
//       // All fields are valid.
//       // Additional order submission logic can go here.
//       // For now, we simply navigate to the home screen.
//       Navigator.pop(
//         context,
//         // (context) => const ClientHomepageView(),
//       );
//     } else {
//       // If the form is not valid, show a snackbar message.
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please fill all address fields")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Order"),
//         centerTitle: true,
//         backgroundColor: Colors.orange.shade100, // Background color of the card
//            // Color change for the AppBar
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Display Cart Items
//             const Text(
//               "Your Cart Items",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: widget.cartItems.length,
//               itemBuilder: (context, index) {
//                 final item = widget.cartItems[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 8),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   color: Colors.white, // Background color of the card
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Row(
//                       children: [
//                         Image.network(
//                           "${ApiEndpoints.imageUrl}${item.productImage}",
//                           width: 90, // Adjusted image size
//                           height: 90, // Adjusted image size
//                           fit: BoxFit.cover,
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item.productName,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 item.productDescription,
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey.shade600,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2,
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 "Quantity: ${item.quantity}",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Text(
//                           'Rs. ${(item.price * item.quantity).toStringAsFixed(2)}', // Changed $ to Rs.
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 16),
//             // Total Price
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Total:",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'Rs. ${widget.totalPrice.toStringAsFixed(2)}', // Changed $ to Rs.
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),
//             // Address Form
//             const Text(
//               "Enter Shipping Address",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   // Street Address
//                   TextFormField(
//                     controller: _streetController,
//                     decoration: const InputDecoration(
//                       labelText: "Street Address",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter street address";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 12),
//                   // City
//                   TextFormField(
//                     controller: _cityController,
//                     decoration: const InputDecoration(
//                       labelText: "City",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter city";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 12),
//                   // Province
//                   TextFormField(
//                     controller: _provinceController,
//                     decoration: const InputDecoration(
//                       labelText: "Province",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter province";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 12),
//                   // Post Code
//                   TextFormField(
//                     controller: _postCodeController,
//                     decoration: const InputDecoration(
//                       labelText: "Post Code",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter post code";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 12),
//                   // Country
//                   TextFormField(
//                     controller: _countryController,
//                     decoration: const InputDecoration(
//                       labelText: "Country",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter country";
//                       }
//                       return null;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             // Place Order Button
//             ElevatedButton(
//               onPressed: _placeOrder,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.black, // Button color matches the cart theme
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//               child: const Text(
//                 "Place Order",
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }