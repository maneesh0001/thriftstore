// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:thrift_store/features/setting/presentation/view_model/setting_cubit.dart';

// class SettingScreenView extends StatelessWidget {
//   const SettingScreenView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final settingCubit = context.read<SettingCubit>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Settings',
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: const Color(0xFFFFF8E7),
//         foregroundColor: Colors.black,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             _buildListTile(Icons.feedback_outlined, "Feedback", () {
//               settingCubit.navigateToFeedbackPage(context);
//             }),
//             _buildListTile(Icons.question_answer_outlined, "FAQs", () {
//               settingCubit.navigateToFaqPage(context);
//             }),
//             _buildListTile(Icons.info_outline, "About Us", () {
//               settingCubit.navigateToAboutPage(context);
//             }),
//             _buildListTile(Icons.money_outlined, "Delivery Charge", () {
//               settingCubit.navigateToDeliveryPage(context);
//             }),
//             _buildListTile(Icons.description_outlined, "Terms and Conditions",
//                 () {
//               settingCubit.navigateToTermsPage(context);
//             }),
//             _buildListTile(Icons.privacy_tip_outlined, "Privacy Policy", () {
//               settingCubit.navigateToPrivacyPage(context);
//             }),
//             const Spacer(),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ListTile(
//         leading: Icon(icon, color: Colors.brown),
//         title: Text(
//           title,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//         ),
//         trailing:
//             const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
//         onTap: onTap,
//       ),
//     );
//   }
// }
