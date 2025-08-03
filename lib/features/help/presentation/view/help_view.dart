import 'package:flutter/material.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help & Support',
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
            _buildHelpItem(
              "1. How do I place an order?",
              "To place an order, browse the available items, add them to your cart, and proceed to checkout. "
              "You can choose your preferred payment method before confirming the order.",
            ),
            _buildHelpItem(
              "2. How can I track my order?",
              "Once your order is placed, you can track its status in the 'Orders' section. "
              "You'll also receive updates via notifications.",
            ),
            _buildHelpItem(
              "3. What payment methods are accepted?",
              "We accept major debit/credit cards, digital wallets, and cash on delivery (COD) in selected locations.",
            ),
            _buildHelpItem(
              "4. Can I modify or cancel my order after placing it?",
              "Orders can be modified or canceled within 5 minutes of placement. "
              "Once dispatched, modifications may not be possible.",
            ),
            _buildHelpItem(
              "5. How do I contact customer support?",
              "If you need assistance, go to the 'Support' section in the app or contact us through the live chat feature.",
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            answer,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}