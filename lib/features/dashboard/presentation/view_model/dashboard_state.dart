// import 'package:equatable/equatable.dart';

// class DashboardState extends Equatable {
//   final List<String>
//       bannerImagePaths; // Renamed for clarity, used for the auto-scrolling banner
//   final List<String> topPicksImagePaths; // New list for Top Picks products
//   final String
//       bannerImagePath; // This might be for a single, static main banner if needed separately
//   final String category;
//   final bool isLoading;
//   final String errorMessage;

//   const DashboardState({
//     required this.bannerImagePaths,
//     required this.topPicksImagePaths, // New: Include in constructor
//     required this.bannerImagePath,
//     required this.category,
//     required this.isLoading,
//     required this.errorMessage,
//   });

//   /// Initial state for the dashboard, setting default values and `isLoading` to false
//   /// as the `DashboardBloc` immediately dispatches `LoadDashboardData`.
//   factory DashboardState.initial() {
//     return const DashboardState(
//       bannerImagePaths: [],
//       topPicksImagePaths: [], // New: Initialize empty
//       bannerImagePath: '',
//       category: 'F2K Store',
//       isLoading: false,
//       errorMessage: '',
//     );
//   }

//   /// Creates a new `DashboardState` instance with updated values.
//   DashboardState copyWith({
//     List<String>? bannerImagePaths,
//     List<String>? topPicksImagePaths, // New: Include in copyWith
//     String? bannerImagePath,
//     String? category,
//     bool? isLoading,
//     String? errorMessage,
//   }) {
//     return DashboardState(
//       bannerImagePaths: bannerImagePaths ?? this.bannerImagePaths,
//       topPicksImagePaths:
//           topPicksImagePaths ?? this.topPicksImagePaths, // New: Update here
//       bannerImagePath: bannerImagePath ?? this.bannerImagePath,
//       category: category ?? this.category,
//       isLoading: isLoading ?? this.isLoading,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }

//   @override
//   List<Object> get props => [
//         bannerImagePaths,
//         topPicksImagePaths,
//         bannerImagePath,
//         category,
//         isLoading,
//         errorMessage
//       ];
// }


// features/dashboard/presentation/view_model/dashboard_state.dart

import 'package:equatable/equatable.dart';
// IMPORTANT: Import your ProductEntity class
import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';

class DashboardState extends Equatable {
  final List<String> bannerImagePaths; // For the auto-scrolling banner
  // --- UPDATED: Holds full product data now ---
  final List<ProductEntity> topPicks;
  final String category;
  final bool isLoading;
  final String errorMessage;

  const DashboardState({
    required this.bannerImagePaths,
    required this.topPicks, // Updated
    required this.category,
    required this.isLoading,
    required this.errorMessage,
  });

  factory DashboardState.initial() {
    return const DashboardState(
      bannerImagePaths: [],
      topPicks: [], // Updated: Initialize as an empty list of products
      category: 'F2K Store',
      isLoading: false,
      errorMessage: '',
    );
  }

  DashboardState copyWith({
    List<String>? bannerImagePaths,
    List<ProductEntity>? topPicks, // Updated
    String? category,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DashboardState(
      bannerImagePaths: bannerImagePaths ?? this.bannerImagePaths,
      topPicks: topPicks ?? this.topPicks, // Updated
      category: category ?? this.category,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        bannerImagePaths,
        topPicks, // Updated
        category,
        isLoading,
        errorMessage,
      ];
}