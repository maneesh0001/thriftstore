import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thrift_store/features/home/presentation/view_model/home_cubit.dart';
import 'package:thrift_store/features/home/presentation/view_model/home_state.dart';
import 'package:thrift_store/features/sensor/direction.detector.dart';

class ClientHomepageView extends StatelessWidget {
  const ClientHomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80), // Adjust height as needed
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: SvgPicture.asset(
                  'assets/icons/logo-1.svg',
                  height: 70,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.explore, color: Colors.black),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            // child: const DirectionDetector(),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            body: state.views[state.selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_outlined),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  label: 'Settings',
                ),
              ],
              currentIndex: state.selectedIndex,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.white,
              backgroundColor: Color(0xFFC9A060),
              onTap: (index) {
                context.read<HomeCubit>().onTabTapped(index);
              },
            ),
          );
        },
      ),
    );
  }
}
