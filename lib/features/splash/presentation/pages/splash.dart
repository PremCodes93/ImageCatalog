import 'package:flutter/material.dart';
import 'package:image_listing_app/presentation/extensions/app_theme_extension.dart';
import 'package:image_listing_app/presentation/routes/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  static const int fadeInDuration = 1;
  static const int fadeOutDuration = 900;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: fadeInDuration), () {
          _controller.reverse();
          Future.delayed(Duration(milliseconds: fadeOutDuration), () {
            if (mounted) {
              Navigator.of(context).pushReplacementNamed(Routes.listingPage);
            }
          });
        });
      }
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
      backgroundColor: context.appThemeData.splashStyle.bgColor,
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Text(
            "Welcome",
            style: context.appThemeData.splashStyle.splashTextStyle,
          ),
        ),
      ),
    );
  }
}
