import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? buttonColor;
  final Color? textColor;
  final double? fontSize;

  const CustomFilledButton({
    super.key,
    this.onPressed,
    required this.text,
    this.buttonColor,
    this.textColor = Colors.white,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(10);
    final textStyle = Theme.of(context).textTheme;

    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        textStyle: textStyle.titleSmall,
        backgroundColor: buttonColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: radius,
            bottomRight: radius,
            topLeft: radius,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: fontSize ?? 20,
        ),
      ),
    );
  }
}
