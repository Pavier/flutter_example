import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessView extends StatefulWidget {
  const SuccessView({super.key});

  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 100,
      ),
      child: Center(
        child: Lottie.asset('assets/success.json',
          width: 50,
          height: 50,
          repeat: false,
        ),
      ),
    );
  }
}
