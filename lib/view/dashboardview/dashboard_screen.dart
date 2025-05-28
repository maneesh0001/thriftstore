import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

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
            icon: Image.asset('assets/icons/home.png', width: 24, height: 24),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/add.png', width: 24, height: 24),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/search.png', width: 24, height: 24),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/heart.png', width: 24, height: 24),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/user.png', width: 24, height: 24),
            label: '',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'F2K',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'STORE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/fas.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Recently added title
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

              // Recently added items
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

              // Grid Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildGridItem('assets/images/tsh.jpg'),
                    const SizedBox(width: 16),
                    buildGridItem('assets/images/lap.jpg', showSeeAll: true),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for horizontal card items
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

  // Widget for grid items with optional 'See all'
  Widget buildGridItem(String imagePath, {bool showSeeAll = false}) {
    return Expanded(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imagePath, height: 200, fit: BoxFit.cover),
          ),
          if (showSeeAll)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'See all',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
