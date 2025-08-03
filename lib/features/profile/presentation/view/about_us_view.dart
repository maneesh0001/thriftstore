import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../view_model/about_us_bloc.dart';
import '../view_model/about_us_event.dart';
import '../view_model/about_us_state.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AboutBloc()..add(LoadAboutContent()),
      child: Scaffold(
        body: BlocBuilder<AboutBloc, AboutState>(
          builder: (context, state) {
            if (state is AboutLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AboutError) {
              return Center(child: Text(state.message));
            } else if (state is AboutLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 260.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/jewels.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.black.withOpacity(0.1),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Elevate your senses with our exquisite collection of luxury jewellery, crafted with the finest attention to detail.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),

                    // About Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'About Elegance Affair',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            state.aboutText,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            state.missionText,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            state.valuesText,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // Image Section
                    Center(
                      child: Container(
                        width: 300.0,
                        height: 200.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10.0,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/images/jewellryyyy.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),

                    // Social Media Icons
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.instagram),
                            color: Colors.purple,
                            iconSize: 30.0,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 16.0),
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.github),
                            color: Colors.black,
                            iconSize: 30.0,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 16.0),
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.facebook),
                            color: Colors.blue,
                            iconSize: 30.0,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}