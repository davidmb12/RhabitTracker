import 'package:flutter/cupertino.dart';

class CustomSpacer extends StatelessWidget {
  const CustomSpacer({Key? key, required this.height}) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
