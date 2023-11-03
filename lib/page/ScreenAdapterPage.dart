import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapterPage extends StatefulWidget {
  const ScreenAdapterPage({super.key});

  @override
  State<ScreenAdapterPage> createState() => _ScreenAdapterPageState();
}

class _ScreenAdapterPageState extends State<ScreenAdapterPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,designSize: const Size(750, 1334));
    return Scaffold(
      appBar: AppBar(
        title: const Text("屏幕适配示例"),
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              width: 0.5.sw,
              height: 0.5.sw,
              color: Colors.red,
              child: Center(
                child: Container(
                  width: 0.25.sw,
                  height: 0.25.sw,
                  color: Colors.greenAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
