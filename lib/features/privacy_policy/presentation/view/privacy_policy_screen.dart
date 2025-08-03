import 'package:flutter/material.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
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
            _buildPolicyTitle("1. Data Protection & Privacy"),
            _buildPolicyDescription(
                "At Ailav, we take your privacy seriously. We are committed to protecting "
                "your personal data and ensuring that it remains secure at all times."),
            _buildPolicyTitle("2. No Data Selling or Sharing"),
            _buildPolicyDescription(
                "We do not sell, trade, or share your personal data with any third parties. "
                "Your information is used strictly for providing and improving our services."),
            _buildPolicyTitle("3. Secure Transactions"),
            _buildPolicyDescription(
                "All transactions and payment details are encrypted and processed securely. "
                "We do not store your payment information beyond what is necessary for order processing."),
            _buildPolicyTitle("4. User Control Over Data"),
            _buildPolicyDescription(
                "You have the right to access, modify, or delete your personal information. "
                "If you wish to update your data or request its removal, please contact our support team."),
            _buildPolicyTitle("5. Compliance with Regulations"),
            _buildPolicyDescription(
                "We adhere to all applicable data protection laws, ensuring compliance "
                "with GDPR and other privacy regulations to safeguard user information."),
            _buildPolicyTitle("6. Transparency & Accountability"),
            _buildPolicyDescription(
                "We operate with full transparency regarding data usage and privacy. "
                "If we make any changes to our policy, users will be notified promptly."),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPolicyDescription(String description) {
    return Text(
      description,
      style: const TextStyle(fontSize: 16),
    );
  }
}