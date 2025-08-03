// // lib/features/booking/presentation/pages/booking_page.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:thrift_store/features/bookings/presentation/view_model/booking_event.dart';
// import 'package:thrift_store/features/bookings/presentation/view_model/booking_state.dart';
// import 'package:thrift_store/features/bookings/presentation/view_model/booking_view_model.dart';

// import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart'; // Import CartItemEntity

// class BookingPage extends StatefulWidget {
//   // Receive cart items and total price as arguments
//   final List<CartItemEntity> cartItems;
//   final double cartTotal;

//   const BookingPage({
//     super.key,
//     required this.cartItems,
//     required this.cartTotal,
//   });

//   @override
//   State<BookingPage> createState() => _BookingPageState();
// }

// class _BookingPageState extends State<BookingPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Removed: context.read<BookingBloc>().add(const FetchBookingsEvent());
//     // This page is now for confirming the current cart as a booking.
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Confirm Your Booking')), // Updated title
//       body: BlocListener<BookingBloc, BookingState>(
//         listener: (context, bookingState) {
//           if (bookingState.status == BookingStatus.success && bookingState.latestBooking != null) {
//             // Booking successful! Show confirmation and clear cart
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Booking successful!')),
//             );
//             // Optionally, clear the cart after successful booking (handled by CartBloc)
//             // You might want to navigate back to home or a dedicated "Order Placed" page
//             Navigator.of(context).popUntil((route) => route.isFirst); // Go back to the first route (e.g., home)
//           } else if (bookingState.status == BookingStatus.failure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Booking failed: ${bookingState.error}')),
//             );
//           }
//         },
//         child: BlocBuilder<BookingBloc, BookingState>(
//           builder: (context, state) {
//             // Display cart items for confirmation
//             if (widget.cartItems.isEmpty) {
//               return const Center(child: Text('No items to book. Please add items to cart first.'));
//             }

//             return Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: widget.cartItems.length,
//                     itemBuilder: (context, index) {
//                       final CartItemEntity item = widget.cartItems[index];
//                       return ListTile(
//                         leading: const Icon(Icons.shopping_bag), // Changed icon for booking confirmation
//                         title: Text(item.productName ?? 'No Name'),
//                         subtitle: Text('Price: ₹${item.price ?? 0} x ${item.quantity}'),
//                         trailing: Text('₹${((item.price ?? 0.0) * item.quantity).toStringAsFixed(2)}'),
//                       );
//                     },
//                   ),
//                 ),
//                 const Divider(),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text("Total Payable", // Changed text for clarity
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold)),
//                           Text("₹${widget.cartTotal.toStringAsFixed(2)}",
//                               style: const TextStyle(fontSize: 18)),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       // Confirm Booking Button
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: state.status == BookingStatus.loading
//                               ? null // Disable button while loading
//                               : () {
//                                   // Dispatch CreateBookingEvent when confirmed
//                                   context.read<BookingBloc>().add(const CreateBookingEvent());
//                                 },
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 15),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: state.status == BookingStatus.loading
//                               ? const CircularProgressIndicator(color: Colors.white)
//                               : const Text(
//                                   'Confirm Booking',
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                         ),
//                       ),
//                       if (state.status == BookingStatus.failure && state.error != null)
//                         Padding(
//                           padding: const EdgeInsets.only(top: 10.0),
//                           child: Text(
//                             'Error: ${state.error}',
//                             style: const TextStyle(color: Colors.red),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                     ],
//                   ),
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart'; // <-- Added
import 'package:thrift_store/features/bookings/presentation/view_model/booking_event.dart';
import 'package:thrift_store/features/bookings/presentation/view_model/booking_state.dart';
import 'package:thrift_store/features/bookings/presentation/view_model/booking_view_model.dart';
import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';

class BookingPage extends StatefulWidget {
  final List<CartItemEntity> cartItems;
  final double cartTotal;

  const BookingPage({
    super.key,
    required this.cartItems,
    required this.cartTotal,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> _authenticateWithBiometrics() async {
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isDeviceSupported = await auth.isDeviceSupported();

      if (!canCheckBiometrics || !isDeviceSupported) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Biometric authentication not available")),
        );
        return false;
      }

      bool authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to confirm booking',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      return authenticated;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Authentication error: $e")),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Your Booking')),
      body: BlocListener<BookingBloc, BookingState>(
        listener: (context, bookingState) {
          if (bookingState.status == BookingStatus.success &&
              bookingState.latestBooking != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Booking successful!')),
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (bookingState.status == BookingStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Booking failed: ${bookingState.error}')),
            );
          }
        },
        child: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (widget.cartItems.isEmpty) {
              return const Center(child: Text('No items to book.'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final CartItemEntity item = widget.cartItems[index];
                      return ListTile(
                        leading: const Icon(Icons.shopping_bag),
                        title: Text(item.productName ?? 'No Name'),
                        subtitle: Text(
                          'Price: ₹${item.price ?? 0} x ${item.quantity}',
                        ),
                        trailing: Text(
                          '₹${((item.price ?? 0.0) * item.quantity).toStringAsFixed(2)}',
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
                          const Text(
                            "Total Payable",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "₹${widget.cartTotal.toStringAsFixed(2)}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.status == BookingStatus.loading
                              ? null
                              : () async {
                                  bool authenticated =
                                      await _authenticateWithBiometrics();
                                  if (authenticated) {
                                    context
                                        .read<BookingBloc>()
                                        .add(const CreateBookingEvent());
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: state.status == BookingStatus.loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  'Confirm Booking',
                                  style: TextStyle(fontSize: 18),
                                ),
                        ),
                      ),
                      if (state.status == BookingStatus.failure &&
                          state.error != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Error: ${state.error}',
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
