import 'package:flutter/material.dart';

class BuyProduct extends StatelessWidget {
  const BuyProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/fas.jpg',
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Mens Vintage Button Up Short Sleeve Shirts',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            const Text(
              'Rs 1700.00',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 10),

            const Text(
              'one time used  for contact 9868******',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTag("Non-Exchangeable"),
                buildTag("Non-Refundable"),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              'seller detail: Rabish Kandel\n'
              'Contact:\n'
              'email: kandelrabish22@gmail.com\n'
              'city: Ktm',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 239, 62, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () {
            // handle buy action
          },
          child: const Text(
            'Buy Now',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
