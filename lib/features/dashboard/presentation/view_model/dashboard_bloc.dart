


// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dashboard_event.dart';
// import 'dashboard_state.dart';

// class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
//   DashboardBloc() : super(DashboardState.initial()) {
//     on<LoadDashboardData>(_onLoadDashboardData);

//     // Automatically trigger the data load when the BLoC is created
//     add(LoadDashboardData());
//   }

//   /// Handles the `LoadDashboardData` event to fetch and update dashboard content.
//   void _onLoadDashboardData(
//       LoadDashboardData event, Emitter<DashboardState> emit) async {
//     try {
//       emit(state.copyWith(
//           isLoading: true,
//           errorMessage: '')); // Set loading, clear previous errors

//       // --- Simulate fetching data ---
//       await Future.delayed(
//           const Duration(seconds: 1)); // Simulate network delay

//       // Distinct images for the auto-scrolling banner
//       final List<String> fetchedBannerImages = [
//         'assets/images/co.jpg', // Make sure you have these specific assets
//         'assets/images/say.jpg',
//         'assets/images/cl.jpg',
//       ];

//       // Distinct images for the "Top Picks" product grid
//       final List<String> fetchedTopPicksImages = [
//         'assets/images/lap.jpg',
//         'assets/images/fas.jpg',
//         'assets/images/tsh.jpg',
//         'assets/images/lap.jpg',
//       ];

//       // The single main banner image (if still used somewhere else)
//       // Otherwise, you can remove 'bannerImagePath' from the state entirely if the carousel
//       // is the only "banner" you need. For now, it's kept as per your original code.
//       const String fetchedMainBanner = 'assets/images/fas.jpg';

//       // --- End Simulation ---

//       emit(state.copyWith(
//         bannerImagePaths: fetchedBannerImages, // Assign to banner
//         topPicksImagePaths: fetchedTopPicksImages, // Assign to top picks
//         bannerImagePath: fetchedMainBanner, // Remains for other uses if any
//         category: 'F2K Store',
//         isLoading: false,
//       ));
//     } catch (e) {
//       emit(state.copyWith(
//           errorMessage: "Failed to load dashboard data: ${e.toString()}",
//           isLoading: false));
//     }
//   }
// }



// features/dashboard/presentation/view_model/dashboard_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
// --- IMPORTANT: Import your use case ---
import 'package:thrift_store/features/product/domain/use_case/get_all_product_usecase.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  // --- ADDED: Dependency for the product use case ---
  final GetAllProductUsecase _getAllProductUsecase;

  DashboardBloc({
    // --- UPDATED: Require the use case in the constructor ---
    required GetAllProductUsecase getAllProductUsecase,
  })  : _getAllProductUsecase = getAllProductUsecase,
        super(DashboardState.initial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
  }

  // --- UPDATED: Logic to fetch real data ---
  void _onLoadDashboardData(
      LoadDashboardData event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      // Fetch Real Product Data using the use case
      final productResult = await _getAllProductUsecase.call();

      // You can still have simulated data for banners
      final List<String> fetchedBannerImages = [
        'assets/images/co.jpg',
        'assets/images/say.jpg',
        'assets/images/cl.jpg',
      ];

      // Handle the success or failure of the product fetch
      productResult.fold(
        (failure) {
          // On failure, emit an error state
          emit(state.copyWith(
            isLoading: false,
            errorMessage: failure.message,
          ));
        },
        (products) {
          // On success, take the first 4 products for "Top Picks"
          final topPicksProducts = products.take(4).toList();

          emit(state.copyWith(
            isLoading: false,
            bannerImagePaths: fetchedBannerImages,
            topPicks: topPicksProducts, // Use the fetched products
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        errorMessage: "Failed to load dashboard data: ${e.toString()}",
        isLoading: false,
      ));
    }
  }
}