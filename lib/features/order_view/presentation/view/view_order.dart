import 'dart:math';

import 'package:flutter/material.dart';

class ViewOrder extends StatelessWidget {
  const ViewOrder({super.key});

  String _generateRandomOrderId() {
    final Random random = Random();
    return List.generate(16, (index) => random.nextInt(10)).join();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> orders = [
      {"status": "Completed", "location": "Kathmandu, Nepal"},
      {"status": "In Progress", "location": "Kathmandu, Nepal"},
      {"status": "Completed", "location": "Kathmandu, Nepal"},
      {"status": "In Progress", "location": "Kathmandu, Nepal"},
      {"status": "Completed", "location": "Kathmandu, Nepal"},
      {"status": "In Progress", "location": "Kathmandu, Nepal"},
      {"status": "Completed", "location": "Kathmandu, Nepal"},
      {"status": "In Progress", "location": "Kathmandu, Nepal"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          final orderId = _generateRandomOrderId();

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2, // Add elevation for a shadow effect
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Status Icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: order["status"] == "Completed"
                          ? Colors.blueGrey // Changed green to blue
                          : Colors.orangeAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      order["status"] == "Completed"
                          ? Icons.check_circle
                          : Icons.timer,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12), // Spacing between icon and text
                  // Order Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order ID: $orderId",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          order["location"],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),







                  ),
                  // Trailing Icon
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}