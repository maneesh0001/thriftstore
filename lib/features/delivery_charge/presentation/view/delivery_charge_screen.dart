import 'package:flutter/material.dart';

class DeliveryChargeView extends StatelessWidget {
  const DeliveryChargeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delivery Charge',
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
            _buildSectionTitle("Delivery Service"),
            _buildSectionDescription(
                "We provide fast and reliable delivery services for all beverage and grocery orders. "
                "Our delivery charges are calculated based on the total order value and distance to "
                "ensure fair pricing. Below is our detailed delivery pricing policy."),
            _buildSectionTitle("Delivery Charge Policy"),
            _buildDeliveryChargeItem("Fresh Order", "Rs. 100 per order"),
            _buildDeliveryChargeItem(
                "Beverage Shops & Other Stores",
                "Delivery charges are based on total bill and road distance."),
            _buildDeliveryChargeItem("Up to 1.5 Km", "Rs. 25"),
            _buildDeliveryChargeItem("After 1.5 Km", "Additional Rs. 25/km"),
            _buildDeliveryChargeItem(
                "Order Value Above Rs. 2000",
                "Max charge: Rs. 80 (if distance > 8km, Rs. 25/km applies)"),
            _buildDeliveryChargeItem(
                "Order Value Above Rs. 7000", "Free delivery"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSectionDescription(String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        description,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildDeliveryChargeItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.local_shipping, size: 20, color: Colors.black54),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}