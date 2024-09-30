import 'dart:async';
import 'package:flutter/material.dart';
import 'package:to_do_list/app/todo_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/utils/utils.dart';

class SplashScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay navigation to ensure it occurs after the widget is built
    Future.delayed(Duration(seconds: 1), () {
      // Ensure context is still valid before navigating
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => TodoApp(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    return Scaffold(
      body: Center(
        child: Container(
            height: deviceSize.height,
            width: deviceSize.width,
            color: Color(0xff834AA4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('Assets/Images/logo.png'),
              ],
            )
        ),
      ),
    );
  }
}
