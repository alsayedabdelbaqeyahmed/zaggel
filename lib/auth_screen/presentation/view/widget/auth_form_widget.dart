// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zagel/auth_screen/presentation/cubit/auth_cubit.dart';
import 'package:zagel/auth_screen/presentation/cubit/auth_state.dart';
import 'package:zagel/shared_widget/shared_buttons.dart';
import 'package:zagel/shared_widget/shared_form_field.dart';
import 'package:zagel/styles/string_const.dart';
import 'package:zagel/styles/style_const.dart';

class AuthFormWidget extends StatelessWidget {
  const AuthFormWidget({
    super.key,
    required this.size,
    this.isAuthScreen = false,
    required this.formKey,
    required this.controller,
    required this.press,
    required this.text,
    required this.validator,
  });
  final BoxConstraints? size;
  final bool? isAuthScreen;
  final GlobalKey<FormState>? formKey;
  final TextEditingController? controller;
  final VoidCallback? press;
  final String? Function(String?)? validator;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SharedFormField(
            controller: controller,
            validator: validator,
          ),
          SizedBox(height: size!.maxHeight * 0.04),
          SharedButton(
            size: size,
            press: press,
            text: text,
          ),
          SizedBox(height: size!.maxHeight * 0.02),
          isAuthScreen!
              ? Column(
                  children: [
                    Text(
                      AppStringsConstants.terms,
                      style: AppStyleConstants.textStyle(
                        size: size!.maxWidth * 0.025,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      AppStringsConstants.condition,
                      style: AppStyleConstants.textStyle(
                        size: size!.maxWidth * 0.04,
                        isunderLine: true,
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
