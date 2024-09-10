import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final bool loading;
  final String title;
  final VoidCallback onTap;

  const RoundButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient:
              const LinearGradient(colors: [Color(0xff876DFF), Color(0xffFB692A)]),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
        ),
      ),
    );
  }
}
