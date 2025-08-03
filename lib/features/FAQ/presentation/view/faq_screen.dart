import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQs',
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
            _buildFaqItem(
              "1. Who can place an order?",
              "Anyone above the legal drinking age of 18 can place an order. "
              "Our delivery team verifies age upon delivery to ensure responsible consumption.",
            ),
            _buildFaqItem(
              "2. How long does delivery take?",
              "Delivery times vary based on location and order volume, but we aim to deliver within 30-60 minutes.",
            ),
            _buildFaqItem(
              "3. What payment methods do you accept?",
              "We accept all major debit/credit cards, digital wallets, and cash on delivery (COD) where applicable.",
            ),
            _buildFaqItem(
              "4. Can I cancel or modify my order?",
              "Orders can be canceled or modified within 5 minutes of placing them. "
              "Once dispatched, modifications may not be possible.",
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
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