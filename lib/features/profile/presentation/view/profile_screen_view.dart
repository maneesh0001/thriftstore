// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:permission_handler/permission_handler.dart';

// // Your ProfileCubit
// import 'package:thrift_store/features/profile/presentation/view_model/profile_cubit.dart';

// // Corrected import for LoginPage
// import 'package:thrift_store/features/auth/presentation/view/login_page.dart'; // Assuming your LoginPage is here

// // Corrected import for TokenSharedPrefs
// // IMPORTANT: Ensure your 'token_shared_prefs.dart' file actually contains a class named 'TokenSharedPrefs'
// import 'package:thrift_store/app/shared_prefs/token_shared_prefs.dart'; // Assuming the class is TokenSharedPrefs (plural)

// class ProfileScreenView extends StatefulWidget {
//   const ProfileScreenView({super.key});

//   @override
//   State<ProfileScreenView> createState() => _ProfileScreenViewState();
// }

// class _ProfileScreenViewState extends State<ProfileScreenView> {
//   File? _image;

//   Future<void> checkCameraPermission() async {
//     var status = await Permission.camera.request();
//     if (status.isDenied || status.isRestricted) {
//       debugPrint("Camera permission denied or restricted.");
//     }
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     try {
//       final pickedFile = await ImagePicker().pickImage(source: source);
//       if (pickedFile != null) {
//         setState(() {
//           _image = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       debugPrint("Error picking image: $e");
//     }
//   }

//   Future<void> _logout(BuildContext context) async {
//     final sharedPreferences = await SharedPreferences.getInstance();
//     // FIX: Changed to TokenSharedPrefs (plural) to match common convention and likely class name
//     final tokenPrefs = TokenSharedPrefs(sharedPreferences); // <--- FIXED HERE
//     await tokenPrefs.saveToken('');

//     if (context.mounted) {
//       // Your LoginPage is a StatelessWidget, so it doesn't need 'const' after the constructor
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginPage()), // <--- Changed to LoginPage()
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profileCubit = context.read<ProfileCubit>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'My Profile',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFFFFF8E7),
//         foregroundColor: Colors.black,
//         elevation: 1,
//         actions: [
//           IconButton(
//             onPressed: () => _logout(context),
//             icon: const Icon(Icons.logout, color: Colors.black),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             _buildProfileImage(),
//             const SizedBox(height: 12),
//             const Text(
//               "Hi Sushmita !",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 24),

//             _buildProfileOption(Icons.shopping_bag_outlined, "My Orders", () {
//               profileCubit.navigateToOrder(context);
//             }),

//             _buildSectionTitle("MANAGEMENT"),
//             _buildProfileOption(Icons.person_outline, "My Information", () {
//               profileCubit.navigateToMyInformation(context);
//             }),

//             _buildSectionTitle("SUPPORT"),
//             _buildProfileOption(Icons.help_outline, "Help", () {
//               profileCubit.navigateToHelp(context);
//             }),
//             _buildProfileOption(Icons.chat_bubble_outline, "Support", () {
//               profileCubit.navigateToSupport(context);
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileImage() {
//     return Stack(
//       alignment: Alignment.bottomRight,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(4),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(color: Colors.grey.shade300, width: 2),
//           ),
//           child: CircleAvatar(
//             radius: 50,
//             backgroundColor: Colors.grey.shade300,
//             backgroundImage: _image != null ? FileImage(_image!) : null,
//             child: _image == null
//                 ? const Icon(Icons.person, size: 50, color: Colors.white)
//                 : null,
//           ),
//         ),
//         GestureDetector(
//           onTap: _showImagePickerOptions,
//           child: Container(
//             padding: const EdgeInsets.all(6),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: const Color(0xFFC9A060),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.2),
//                   blurRadius: 5,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }

//   void _showImagePickerOptions() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _buildImagePickerButton(
//                 icon: Icons.camera,
//                 label: 'Camera',
//                 onTap: () {
//                   checkCameraPermission();
//                   _pickImage(ImageSource.camera);
//                   Navigator.pop(context);
//                 },
//               ),
//               const SizedBox(height: 10),
//               _buildImagePickerButton(
//                 icon: Icons.image,
//                 label: 'Gallery',
//                 onTap: () {
//                   _pickImage(ImageSource.gallery);
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildImagePickerButton({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return ElevatedButton.icon(
//       onPressed: onTap,
//       icon: Icon(icon, size: 20),
//       label: Text(label, style: const TextStyle(fontSize: 16)),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFFC9A060),
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 24, bottom: 8),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.bold,
//           color: Colors.blueGrey,
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap) {
//     return Column(
//       children: [
//         // FIX: Removed 'const' before Icon
//         ListTile(
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12),
//           leading: Icon(icon, color: const Color(0xFFC9A060)), // <--- FIXED HERE
//           title: Text(
//             title,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           trailing: const Icon(Icons.arrow_forward_ios, size: 18),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           tileColor: Colors.grey.shade100,
//           onTap: onTap,
//         ),
//         const SizedBox(height: 8),
//       ],
//     );
//   }
// }