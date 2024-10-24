import 'package:flutter/material.dart';

class CustomTitleForScreen extends StatelessWidget {
  final String title;

  const CustomTitleForScreen({super.key, this.title = 'Sin Titulo'});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      width: size.width * 0.7,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: primaryColor,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: primaryColor,
          overflow: TextOverflow.clip,
        ),
        softWrap: true,
      ),
    );
  }
}
