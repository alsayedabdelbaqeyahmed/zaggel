import 'package:flutter/material.dart';
import 'package:zagel/styles/colors.dart';
import 'package:zagel/styles/style_const.dart';

import '../auth_screen/presentation/cubit/auth_cubit.dart';

class SharedButton extends StatelessWidget {
  const SharedButton({
    Key? key,
    required this.size,
    required this.press,
    this.text,
  }) : super(key: key);

  final BoxConstraints? size;
  final VoidCallback? press;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size!.maxWidth,
      height: size!.maxWidth * 0.15,
      decoration: const BoxDecoration(
        color: AppColorsConstants.conAppNameColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: TextButton(
        onPressed: press,
        child: Text(
          text!,
          style: AppStyleConstants.textStyle(
            colr: AppColorsConstants.getOtpColor,
            size: 18,
          ),
        ),
      ),
    );
  }
}
