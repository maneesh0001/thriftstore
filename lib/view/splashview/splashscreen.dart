import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrift_store/app/service_locator/service_locator.dart';
import 'package:thrift_store/features/auth/presentation/view/login_page.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _colorAnimation = ColorTween(
      begin: Colors.deepOrange,
      end: Colors.redAccent,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _bounceAnimation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacityAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);

    Future.delayed(const Duration(seconds: 3), () {
      _controller.stop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: serviceLocator<LoginViewModel>(),
                  child: LoginPage(),
                )),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: Colors.black),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Opacity(
                      opacity: _opacityAnimation.value,
                      child: Transform.translate(
                        offset: Offset(0, -_bounceAnimation.value),
                        child: Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Icon(
                            Icons.store,
                            size: 100,
                            color: _colorAnimation.value,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Opacity(
                      opacity: _opacityAnimation.value,
                      child: Transform.translate(
                        offset: Offset(0, _bounceAnimation.value / 2),
                        child: Text(
                          'Feri Pheri Kin',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                            color: _colorAnimation.value,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 120, // Smaller width
                      child: LinearProgressIndicator(
                        valueColor: _colorAnimation,
                        backgroundColor: Colors.grey[800],
                        minHeight: 4, // Thinner bar
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
