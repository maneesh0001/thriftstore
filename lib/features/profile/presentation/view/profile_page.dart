// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:permission_handler/permission_handler.dart';

// // Your ProfileCubit
// import 'package:thrift_store/features/profile/presentation/view_model/profile_cubit.dart';

// // Corrected import for LoginPage
// import 'package:thrift_store/features/auth/presentation/view/login_page.dart';

// // Corrected import for TokenSharedPrefs
// // IMPORTANT: Ensure your 'token_shared_prefs.dart' file actually contains a class named 'TokenSharedPrefs'
// import 'package:thrift_store/app/shared_prefs/token_shared_prefs.dart';
// import 'package:thrift_store/app/shared_prefs/user_shared_prefs.dart'; // Import your UserSharedPrefs

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   File? _image;
//   String _userName =
//       "User"; // Default name, will be updated from SharedPreferences
//   late UserSharedPrefs
//       _userSharedPrefs; // Declare late to initialize in initState

      

//   @override
//   void initState() {
//     super.initState();
//     _initSharedPreferencesAndLoadUserData();
//   }

//   Future<void> _initSharedPreferencesAndLoadUserData() async {
//     final sharedPreferences = await SharedPreferences.getInstance();
//     _userSharedPrefs = UserSharedPrefs(sharedPreferences);
//     await _loadUserName();
//   }

//   Future<void> _loadUserName() async {
//     final result = await _userSharedPrefs.getUserData();
//     result.fold(
//       (failure) {
//         debugPrint("Error loading user data: ${failure.message}");
//         // Optionally, handle specific failures, e.g., navigate to login if no data
//       },
//       (userData) {
//         setState(() {
//           _userName = userData.name;
//         });
//       },
//     );
//   }

//   Future<void> checkCameraPermission() async {
//     var status = await Permission.camera.request();
//     if (status.isDenied || status.isRestricted) {
//       debugPrint("Camera permission denied or restricted.");
//       // You might want to show a dialog here explaining why permission is needed
//       // and direct the user to app settings.
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//                 "Camera permission denied. Please enable it in app settings."),
//           ),
//         );
//       }
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
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Failed to pick image: $e"),
//           ),
//         );
//       }
//     }
//   }

//   Future<void> _logout(BuildContext context) async {
//     final sharedPreferences = await SharedPreferences.getInstance();
//     final tokenPrefs = TokenSharedPrefs(sharedPreferences);
//     await tokenPrefs.saveToken(''); // Clear the token

//     // Also clear all user data from UserSharedPrefs on logout
//     await _userSharedPrefs.clear();

//     if (context.mounted) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => LoginPage(),
//         ),
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
//             Text(
//               "Hi $_userName !", // <--- DYNAMIC NAME HERE!
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
//         ListTile(
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12),
//           leading: Icon(icon, color: const Color(0xFFC9A060)),
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


import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';

// Your ProfileCubit
import 'package:thrift_store/features/profile/presentation/view_model/profile_cubit.dart';

// Corrected import for LoginPage
import 'package:thrift_store/features/auth/presentation/view/login_page.dart';

// Corrected import for TokenSharedPrefs
import 'package:thrift_store/app/shared_prefs/token_shared_prefs.dart';
import 'package:thrift_store/app/shared_prefs/user_shared_prefs.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  String _userName = "User";
  late UserSharedPrefs _userSharedPrefs;

  // Shake detection variables
  StreamSubscription? _accelerometerSubscription;
  static const double shakeThreshold = 15.0; // Adjust sensitivity
  DateTime _lastShakeTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _initSharedPreferencesAndLoadUserData();
    _startShakeDetection();
  }

  Future<void> _initSharedPreferencesAndLoadUserData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _userSharedPrefs = UserSharedPrefs(sharedPreferences);
    await _loadUserName();
  }

  Future<void> _loadUserName() async {
    final result = await _userSharedPrefs.getUserData();
    result.fold(
      (failure) {
        debugPrint("Error loading user data: ${failure.message}");
      },
      (userData) {
        setState(() {
          _userName = userData.name;
        });
      },
    );
  }

  Future<void> checkCameraPermission() async {
    var status = await Permission.camera.request();
    if (status.isDenied || status.isRestricted) {
      debugPrint("Camera permission denied or restricted.");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Camera permission denied. Please enable it in app settings."),
          ),
        );
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to pick image: $e"),
          ),
        );
      }
    }
  }

  Future<void> _logout(BuildContext context) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final tokenPrefs = TokenSharedPrefs(sharedPreferences);
    await tokenPrefs.saveToken('');
    await _userSharedPrefs.clear();

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  /// Shake detection setup
  void _startShakeDetection() {
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      double acceleration =
          sqrt(event.x * event.x + event.y * event.y + event.z * event.z);

      if (acceleration > shakeThreshold) {
        final now = DateTime.now();
        if (now.difference(_lastShakeTime) > const Duration(seconds: 2)) {
          _lastShakeTime = now;
          _onShakeDetected();
        }
      }
    });
  }

  /// Action when shake is detected
  void _onShakeDetected() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Shake detected! Logging out...")),
      );
      _logout(context);
    }
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFF8E7),
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileImage(),
            const SizedBox(height: 12),
            Text(
              "Hi $_userName !",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildProfileOption(Icons.shopping_bag_outlined, "My Orders", () {
              profileCubit.navigateToOrder(context);
            }),
            _buildSectionTitle("MANAGEMENT"),
            _buildProfileOption(Icons.person_outline, "My Information", () {
              profileCubit.navigateToMyInformation(context);
            }),
            _buildSectionTitle("SUPPORT"),
            _buildProfileOption(Icons.help_outline, "Help", () {
              profileCubit.navigateToHelp(context);
            }),
            _buildProfileOption(Icons.chat_bubble_outline, "Support", () {
              profileCubit.navigateToSupport(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: _image != null ? FileImage(_image!) : null,
            child: _image == null
                ? const Icon(Icons.person, size: 50, color: Colors.white)
                : null,
          ),
        ),
        GestureDetector(
          onTap: _showImagePickerOptions,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFC9A060),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildImagePickerButton(
                icon: Icons.camera,
                label: 'Camera',
                onTap: () {
                  checkCameraPermission();
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
              _buildImagePickerButton(
                icon: Icons.image,
                label: 'Gallery',
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImagePickerButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      label: Text(label, style: const TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC9A060),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          leading: Icon(icon, color: const Color(0xFFC9A060)),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          tileColor: Colors.grey.shade100,
          onTap: onTap,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
