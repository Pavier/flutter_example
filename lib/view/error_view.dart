import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorView extends StatefulWidget {
  const ErrorView({super.key});

  @override
  State<ErrorView> createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView>{

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 100,
      ),
      child: Center(
        child: Lottie.asset('assets/error.json',
          width: 50,
          height: 50,
          repeat: false,
        ),
      ),
    );
  }
}
