import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/shared/uipath.dart';
import 'package:weather_app/views/view_home.dart';

class ViewSplash extends StatefulWidget {
  ViewSplash({super.key});

  @override
  State<ViewSplash> createState() => _ViewSplashState();
}

class _ViewSplashState extends State<ViewSplash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    Future.delayed(Duration(seconds: 2), () {
      Get.to(() => ViewHome());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: Image.asset(UIPath.splashImage));
  }
}
