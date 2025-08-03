import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ---- IMPORTANT IMPORTS ----
import 'package:thrift_store/app/constant/api/api_endpoints.dart';
// import 'package:thrift_store/app/router/app_router.dart'; // REMOVED: No longer needed
import 'package:thrift_store/app/service_locator/service_locator.dart';
import 'package:thrift_store/features/cart/presentation/view_model/cart_bloc.dart';

import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';
import 'package:thrift_store/features/product/domain/use_case/get_all_product_usecase.dart';
// ADDED: Import the detail view directly
import 'package:thrift_store/features/product/presentation/view/product_detail_view.dart';

import '../view_model/dashboard_bloc.dart';
import '../view_model/dashboard_event.dart';
import '../view_model/dashboard_state.dart';

class Dashboardhomepage extends StatefulWidget {
  const Dashboardhomepage({super.key});

  @override
  State<Dashboardhomepage> createState() => _DashboardhomepageState();
}

class _DashboardhomepageState extends State<Dashboardhomepage> {
  final PageController _pageController = PageController(initialPage: 0);
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll(int itemCount) {
    if ((_timer != null && _timer!.isActive) || itemCount == 0) return;
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_pageController.hasClients && itemCount > 0) {
        _currentPage++;
        if (_currentPage >= itemCount) {
          _currentPage = 0;
          _pageController.jumpToPage(_currentPage);
        } else {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOut,
          );
        }
      }
    });
  }

  void _stopAutoScroll() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          DashboardBloc(getAllProductUsecase: getIt<GetAllProductUsecase>())
            ..add(LoadDashboardData()),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 221, 212, 212),
        appBar: AppBar(
          title: const Text('Thrift Store',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.teal,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {}),
          actions: [
            IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {}),
          ],
        ),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (!state.isLoading && state.bannerImagePaths.isNotEmpty) {
              _startAutoScroll(state.bannerImagePaths.length);
            } else if (state.bannerImagePaths.isEmpty) {
              _stopAutoScroll();
            }

            if (state.isLoading) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.teal));
            }

            if (state.errorMessage.isNotEmpty) {
              return Center(
                  child: Text('Error: ${state.errorMessage}',
                      style: const TextStyle(color: Colors.red)));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Explore',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.teal)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: state.bannerImagePaths.length,
                      onPageChanged: (index) {
                        _currentPage = index;
                        _stopAutoScroll();
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(state.bannerImagePaths[index],
                                fit: BoxFit.cover),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text('Categories',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87)),
                  const SizedBox(height: 10),
                  SizedBox(height: 110, child: _buildCategoryList()),
                  const SizedBox(height: 25),
                  const Text('Top Picks',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87)),
                  const SizedBox(height: 10),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 18,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: state.topPicks.length,
                    itemBuilder: (context, index) {
                      final product = state.topPicks[index];
                      return _buildProductCard(context, product);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    final List<Map<String, dynamic>> categories = [
      {'name': 'Laptop', 'icon': Icons.laptop},
      {'name': 'Clothes', 'icon': Icons.checkroom},
      {'name': 'Shoes', 'icon': Icons.run_circle},
      {'name': 'Sports', 'icon': Icons.sports_baseball},
    ];
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 10),
            child: Column(children: [
              CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.teal.shade50,
                  child: Icon(categories[index]['icon'],
                      color: Colors.teal[700], size: 30)),
              const SizedBox(height: 6),
              Text(categories[index]['name'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600)),
            ]));
      },
    );
  }

  // --- UPDATED METHOD: Uses Navigator.push directly ---
  Widget _buildProductCard(BuildContext context, ProductEntity product) {
    return InkWell(
      onTap: () {
        // This is the direct navigation method without a named router.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailView(product: product),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                '${ApiEndpoints.imageUrl}${product.imageUrl?.replaceFirst("/uploads/", "")}',
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => const Center(
                    child:
                        Icon(Icons.broken_image, size: 40, color: Colors.grey)),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.teal));
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                product.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Rs. ${product.price}',
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.teal),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.add_shopping_cart, color: Colors.teal),
                onPressed: () {
                  context.read<CartBloc>().add(
                        AddProductToCartEvent(
                          productId: product.productId.toString(),
                          productName: product.name,
                          productPrice: product.price.toDouble(),
                          productQuantity: 1,
                        ),
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} added to cart'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}