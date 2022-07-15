import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.child,
      this.primary,
      this.textColor,
      required this.borderRadius})
      : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final Color? primary;
  final Color? textColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: primary,
          onPrimary: textColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          textStyle: const TextStyle(
            fontSize: 16,
          )),
      onPressed: onPressed,
      child: child,
    );
  }
}
