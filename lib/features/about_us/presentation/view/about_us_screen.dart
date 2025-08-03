import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
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
            _buildSectionTitle("Who We Are"),
            _buildSectionDescription(
                "ThriftStore Inc. is your community's go-to destination for pre-loved treasures. "
                "We believe in giving items a second life, promoting sustainable consumption, and "
                "offering unique finds at affordable prices. From vintage apparel to household "
                "goods, we curate a collection that's constantly evolving."),
            _buildSectionTitle("Our Mission"),
            _buildSectionDescription(
                "Our mission is to foster a more sustainable and accessible shopping experience. "
                "We aim to reduce waste by extending the life of quality items, provide affordable "
                "alternatives for everyday needs, and support our local community through responsible "
                "resale practices."),
            _buildSectionTitle("Why Choose Us?"),
            _buildBulletPoint(
                "👕 Discover unique, pre-loved clothing and accessories."),
            _buildBulletPoint(
                "🛋️ Find affordable furniture, home decor, and essential household items."),
            _buildBulletPoint(
                "♻️ Contribute to a sustainable lifestyle by reusing and recycling."),
            _buildBulletPoint(
                "💰 Get great value for money on a wide variety of goods."),
            _buildBulletPoint(
                "🤝 Support a local business that gives back to the community."),
            _buildSectionTitle("Our Commitment"),
            _buildSectionDescription(
                "At ThriftStore Inc., we are deeply committed to environmental sustainability and community "
                "engagement. We carefully select donated items, ensuring they meet our quality standards, "
                "and strive to divert as much as possible from landfills. We also actively participate "
                "in local initiatives to promote eco-conscious living."),
            _buildSectionTitle("Contact Us"),
            _buildSectionDescription(
                "Have questions about donations, specific items, or just want to say hello? "
                "We're here to help! Reach out to us anytime, and our team will be delighted "
                "to assist you."),
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

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 20, color: Colors.green),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
