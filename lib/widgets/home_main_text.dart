import 'package:flutter/material.dart';

class HomeMainText extends StatelessWidget {
  const HomeMainText({Key? key, this.height = 50.0, this.onLongPress})
      : super(key: key);
  final double? height;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Image.asset(
        'assets/images/icon.png',
        height: height,
      ),
    );
  }
}
