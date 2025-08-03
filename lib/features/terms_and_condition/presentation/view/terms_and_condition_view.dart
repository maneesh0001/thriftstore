import 'package:flutter/material.dart';

class TermsAndConditionView extends StatelessWidget {
  const TermsAndConditionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms and Conditions',
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
            _buildTermTitle("1. Age Requirement"),
            _buildTermDescription(
                "To use our services, you must be at least 18 years old. "
                "By placing an order, you confirm that you meet this legal requirement."),
            _buildTermTitle("2. Responsible Consumption"),
            _buildTermDescription(
                "We encourage responsible drinking. Please do not consume alcohol in excess, "
                "and always follow local laws regarding alcohol consumption."),
            _buildTermTitle("3. Order and Delivery"),
            _buildTermDescription(
                "All orders are subject to verification. The delivery personnel may request a valid "
                "ID upon delivery to confirm your age."),
            _buildTermTitle("4. Payment and Refunds"),
            _buildTermDescription(
                "All payments are processed securely. Refunds are only applicable under specific circumstances, "
                "such as incorrect or damaged products."),
            _buildTermTitle("5. Prohibited Activities"),
            _buildTermDescription(
                "Users must not engage in fraudulent activities, misuse the platform, or attempt to purchase "
                "alcohol on behalf of underage individuals."),
            _buildTermTitle("6. Privacy Policy"),
            _buildTermDescription(
                "Your personal information is protected and used solely for order processing and service improvements."),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTermTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTermDescription(String description) {
    return Text(
      description,
      style: const TextStyle(fontSize: 16),
    );
  }
}