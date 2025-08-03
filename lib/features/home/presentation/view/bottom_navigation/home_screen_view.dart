// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:thrift_store/app/constant/api/api_endpoints.dart';
// import 'package:thrift_store/app/service_locator/service_locator.dart';
// import 'package:thrift_store/features/cart/presentation/view_model/cart_bloc.dart';
// import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';
// import 'package:thrift_store/features/product/presentation/view/single_product_view.dart';
// import 'package:thrift_store/features/product/presentation/view_model/product_bloc.dart';


// class HomeScreenView extends StatelessWidget {
//   const HomeScreenView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Dispatch an event to load products when the view is built
//     // This should ideally be done in a BlocConsumer or a separate widget
//     // that handles initial data loading, but for a quick fix, this will work
//     // Ensure this is called only once, perhaps in an initState of a StatefulWidget
//     // or through a listener. For StatelessWidget, consider listening to the bloc state changes.
//     // For now, let's keep it here for demonstration, but be aware of potential multiple calls.
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<ProductBloc>().add(LoadProducts());
//     });

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 10),
//             // Search Bar
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search for jewelry',
//                 prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[200],
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Banner / Offer Section
//             Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 image: const DecorationImage(
//                   image: AssetImage('assets/images/ring.jpg'), // Ensure this asset exists
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   '25% OFF\nToday\'s Special',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     shadows: [
//                       Shadow(
//                         blurRadius: 10,
//                         color: Colors.black.withOpacity(0.5),
//                         offset: const Offset(2, 2),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             // Categories Section
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Text(
//                   'Categories',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'See All',
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildCategory('Rings', Icons.ring_volume_outlined),
//                 _buildCategory('Necklaces', Icons.diamond),
//                 _buildCategory('Earrings', Icons.earbuds),
//               ],
//             ),
//             const SizedBox(height: 20),
//             // Popular Jewelry Section
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Popular Jewelry',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'See All',
//                   style: TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             BlocBuilder<ProductBloc, ProductState>(
//               builder: (context, state) {
//                 if (state.isLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state.error != null) {
//                   return Center(child: Text(state.error!));
//                 } else if (state.products.isEmpty) {
//                   return const Center(child: Text("No jewelry available"));
//                 }
//                 return GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                     childAspectRatio: 0.7,
//                   ),
//                   itemCount: state.products.length,
//                   itemBuilder: (context, index) {
//                     final product = state.products[index];
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => BlocProvider.value(
//                               // Use serviceLocator here
//                               value: serviceLocator<CartBloc>(),
//                               child: SingleProductView(product: product),
//                             ),
//                           ),
//                         );
//                       },
//                       child: _buildProductCard(product),
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCategory(String name, IconData icon) {
//     return Column(
//       children: [
//         Icon(icon, size: 40, color: Colors.orangeAccent),
//         const SizedBox(height: 8),
//         Text(name, style: const TextStyle(fontSize: 14, color: Colors.black87)),
//       ],
//     );
//   }

//   Widget _buildProductCard(ProductEntity product) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 6,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.network(
//               "${ApiEndpoints.imageUrl}${product.imageUrl}",
//               height: 120,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
//                 Text("Stock: ${product.stock}", style: const TextStyle(color: Colors.orangeAccent)),
//                 Text(
//                   product.longDescription,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//                 const SizedBox(height: 5),
//                 Text("Rs. ${product.price}", style: const TextStyle(fontWeight: FontWeight.bold)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }