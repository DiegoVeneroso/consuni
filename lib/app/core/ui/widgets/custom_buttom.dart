import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final double height;
  final Color? color;
  final bool? disable;

  const CustomButtom({
    Key? key,
    required this.label,
    required this.onPressed,
    this.width,
    this.height = 50,
    this.color,
    this.disable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: disable == true ? null : onPressed,
        child: Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(), primary: color),
      ),
    );
  }
}
