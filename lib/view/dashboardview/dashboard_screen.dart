import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../navigation_view/addproduct.dart';
import '../navigation_view/payment.dart';
import '../navigation_view/profile.dart';
import '../navigation_view/search.dart';
import '../dashboardview/buyproduct.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardContent(),
    const Addproduct(),
    const Search(),
    const Payment(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/home.png', width: 30, height: 30),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/add.png', width: 30, height: 30),
            label: 'add',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/search.png', width: 30, height: 30),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/order.png', width: 30, height: 30),
            label: 'order',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/profile.png',
              width: 30,
              height: 30,
            ),
            label: 'profile',
          ),
        ],
      ),
      body: SafeArea(child: _screens[_currentIndex]),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  Widget buildCardItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildGridItem(String imagePath, {bool showSeeAll = false}) {
    return Expanded(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imagePath, height: 200, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'F2K Store',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // Clickable Banner
          Padding(
            padding: const EdgeInsets.only(left: 55),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BuyProduct()),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset('assets/images/fas.jpg', fit: BoxFit.cover),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Recently added
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Recently added",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                buildCardItem('assets/images/2ele.jpg'),
                buildCardItem('assets/images/mbl.jpg'),
                buildCardItem('assets/images/3tshp.jpg'),
                buildCardItem('assets/images/wat.jpg'),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildGridItem('assets/images/tsh.jpg'),
                const SizedBox(width: 16),
                buildGridItem('assets/images/lap.jpg'),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
