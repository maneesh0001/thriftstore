// // lib/features/profile/presentation/view/my_information_view.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart'; // Ensure get_it is in your pubspec.yaml

// // Corrected import path for MyInformationBloc
// import 'package:thrift_store/features/auth/presentation/view_model/update_user/my_information_bloc.dart';
// // Note: You might need to import the MyInformationState and MyInformationEvent classes
// // if they are used directly in this file, or implicitly through the bloc.

// class MyInformationScreen extends StatefulWidget {
//   const MyInformationScreen({super.key});

//   @override
//   State<MyInformationScreen> createState() => _MyInformationScreenState();
// }

// class _MyInformationScreenState extends State<MyInformationScreen> {
//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();

//   late MyInformationBloc _myInformationBloc; // This will be provided via GetIt

//   @override
//   void initState() {
//     super.initState();
//     // Retrieve the MyInformationBloc instance from GetIt
//     _myInformationBloc = GetIt.I<MyInformationBloc>();


//     // For example, if MyInformationBloc has a state that holds user data:
//     // _myInformationBloc.stream.listen((state) {
//     //   if (state is MyInformationLoaded) {
//     //     _fullNameController.text = state.user.fullName;
//     //     _emailController.text = state.user.email;
//     //     _phoneController.text = state.user.phone;
//     //     _ageController.text = state.user.age.toString();
//     //     _usernameController.text = state.user.username;
//     //   }
//     // });
   
//     // For example: _myInformationBloc.add(LoadUserInformation());
//   }

//   void _updateUserInformation() {
//     final name = _fullNameController.text.trim();
//     final email = _emailController.text.trim();
//     final phone = _phoneController.text.trim();
//     final age = int.tryParse(_ageController.text.trim()) ?? 0;

//     // Ensure UpdateUserEvent and MyInformationState are defined in their respective files
//     _myInformationBloc.add(
//       UpdateUserEvent( // You'll need to define UpdateUserEvent in my_information_event.dart
//         context: context,
//         name: name,
//         email: email,
//         phone: phone,
//         age: age,
//         onSuccess: () {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("User information updated successfully"),backgroundColor: Colors.green,),
//           );
//         },
//         onFailure: (errorMessage) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(errorMessage), backgroundColor: Colors.red,), // Added red background for error
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Using BlocBuilder with the specific bloc instance from GetIt
//     return BlocBuilder<MyInformationBloc, MyInformationState>(
//       bloc: _myInformationBloc,
//       builder: (context, state) {
//         // You might want to handle different states like MyInformationLoading, MyInformationError
//         // For example, display a CircularProgressIndicator if state is MyInformationLoading
//         // and an error message if state is MyInformationError.
//         // For now, assuming state.isLoading provides the loading status.

//         return Scaffold(
//           appBar: AppBar(
//             title: const Text(
//               'My Information',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.white,
//             foregroundColor: Colors.black,
//             elevation: 0.5,
//           ),
//           body: SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildInputField("Full Name", Icons.person_outline, _fullNameController),
//                 _buildInputField("Email", Icons.email_outlined, _emailController),
//                 _buildInputField("Phone Number", Icons.phone_outlined, _phoneController),
//                 _buildInputField("Age", Icons.cake_outlined, _ageController),
//                 _buildInputField("Username", Icons.account_circle_outlined, _usernameController, isEnabled: false),
//                 const SizedBox(height: 20),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: state.isLoading ? null : _updateUserInformation,
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       textStyle: const TextStyle(fontSize: 16),
//                     ),
//                     child: state.isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text("Submit"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildInputField(String label, IconData icon, TextEditingController controller, {bool isEnabled = true}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15),
//       child: TextFormField(
//         controller: controller,
//         enabled: isEnabled,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _ageController.dispose();
//     _usernameController.dispose();
//     // No need to dispose _myInformationBloc here if it's managed by GetIt as a singleton
//     // If it's registered as a factory, it might need to be closed depending on your lifecycle management strategy.
//     // However, if it's provided via BlocProvider.value higher up, its lifecycle is managed there.
//     super.dispose();
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:thrift_store/features/auth/presentation/view_model/update_user/my_information_bloc.dart';

class MyInformationScreen extends StatefulWidget {
  const MyInformationScreen({super.key});

  @override
  State<MyInformationScreen> createState() => _MyInformationScreenState();
}

class _MyInformationScreenState extends State<MyInformationScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  late MyInformationBloc _myInformationBloc;

  @override
  void initState() {
    super.initState();
    _myInformationBloc = GetIt.I<MyInformationBloc>();
    _loadSavedUserInfo(); // Load saved data from SharedPreferences
  }

  /// Load data from SharedPreferences
  Future<void> _loadSavedUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _fullNameController.text = prefs.getString('fullName') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _phoneController.text = prefs.getString('phone') ?? '';
      _ageController.text = prefs.getInt('age')?.toString() ?? '';
      _usernameController.text = prefs.getString('username') ?? '';
    });
  }

  /// Save data to SharedPreferences
  Future<void> _saveUserInfoLocally({
    required String name,
    required String email,
    required String phone,
    required int age,
    required String username,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', name);
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);
    await prefs.setInt('age', age);
    await prefs.setString('username', username);
  }

  void _updateUserInformation() async {
    final name = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final age = int.tryParse(_ageController.text.trim()) ?? 0;
    final username = _usernameController.text.trim();

    // Save locally
    await _saveUserInfoLocally(
      name: name,
      email: email,
      phone: phone,
      age: age,
      username: username,
    );

    // Optionally trigger BLoC update event
    _myInformationBloc.add(
      UpdateUserEvent(
        context: context,
        name: name,
        email: email,
        phone: phone,
        age: age,
        onSuccess: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("User information updated successfully"),
              backgroundColor: Colors.green,
            ),
          );
        },
        onFailure: (errorMessage) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Data saved locally"),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyInformationBloc, MyInformationState>(
      bloc: _myInformationBloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'My Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0.5,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputField("Full Name", Icons.person_outline, _fullNameController),
                _buildInputField("Email", Icons.email_outlined, _emailController),
                _buildInputField("Phone Number", Icons.phone_outlined, _phoneController),
                _buildInputField("Age", Icons.cake_outlined, _ageController),
                _buildInputField("Username", Icons.account_circle_outlined, _usernameController, isEnabled: false),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.isLoading ? null : _updateUserInformation,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: state.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputField(String label, IconData icon, TextEditingController controller, {bool isEnabled = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        enabled: isEnabled,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _usernameController.dispose();
    super.dispose();
  }
}
