import 'package:flutter/material.dart';
import 'package:zagel/auth_screen/presentation/view/widget/auth_form_widget.dart';

import 'package:zagel/styles/assets.dart';
import 'package:zagel/styles/colors.dart';
import 'package:zagel/styles/string_const.dart';
import 'package:zagel/styles/style_const.dart';

class AuthScreenWidget extends StatelessWidget {
  const AuthScreenWidget({
    super.key,
    this.formKey,
    this.controller,
    this.press,
    this.validator,
    this.text1,
    this.text2,
    this.text,
  });
  final GlobalKey<FormState>? formKey;
  final TextEditingController? controller;
  final VoidCallback? press;
  final String? Function(String?)? validator;
  final String? text;
  final String? text1;
  final String? text2;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                AppAssetsConstants.background,
              ),
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStringsConstants.appName,
                    style: AppStyleConstants.textStyle(),
                  ),
                  SizedBox(height: size.maxHeight * 0.2),
                  Container(
                    padding: EdgeInsetsDirectional.only(
                      start: size.maxWidth * 0.05,
                      end: size.maxWidth * 0.05,
                      top: size.maxWidth * 0.05,
                      bottom: size.maxHeight * 0.05,
                    ),
                    // height: size.maxHeight * 0.5,
                    width: size.maxWidth * 0.85,
                    decoration: BoxDecoration(
                      color: AppColorsConstants.authColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              text1!,
                              style: AppStyleConstants.textStyle(
                                  size: 14, fontWeight: FontWeight.normal),
                            ),
                            Text(
                              text2!,
                              style: AppStyleConstants.textStyle(size: 20),
                            ),
                          ],
                        ),
                        SizedBox(height: size.maxHeight * 0.02),
                        AuthFormWidget(
                          size: size,
                          isAuthScreen: true,
                          controller: controller,
                          formKey: formKey,
                          press: press,
                          text: text,
                          validator: validator,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
