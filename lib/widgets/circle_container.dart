import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget{
  const CircleContainer({super.key,
   required this.color,
    this.child});
  someWidget({Color? color}){}
  final Widget? child;

  final dynamic color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:color,
          border: Border.all(
            color: color,
              width: 2,

          )
      ),
      child: Center(
        child: child,
      ),
    );
  }
}