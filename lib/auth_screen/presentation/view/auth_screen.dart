import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zagel/auth_screen/presentation/cubit/auth_cubit.dart';
import 'package:zagel/auth_screen/presentation/cubit/auth_state.dart';
import 'package:zagel/styles/string_const.dart';
import 'package:zagel/styles/style_const.dart';

import 'widget/auth_screen_widget.dart';

class AuthScreen extends StatelessWidget {
  static const String routesName = '/authScreen';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(backgroundColor: Colors.transparent),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (ctx, state) {
          final authCubit = AuthCubit.get(ctx);
          return AuthScreenWidget(
            text1: AppStringsConstants.enterPhone,
            text2: AppStringsConstants.mobileNumber,
            controller: authCubit.phoneNumber,
            formKey: authCubit.autFformKey,
            validator: (value) {
              debugPrint('lenth is ${value!.length}');
              if (value.isEmpty) {
                return 'please enter a valid phone number';
              }
              // if (value.length < 12) {
              //   return 'please enter your country code\n the your phone nmber';
              // }
              return null;
            },
            press: () async {
              if (authCubit.autFformKey.currentState!.validate()) {
                await authCubit.authWithPhoneNumber(context);
              }
            },
            text: 'Get Otp',
          );
        },
      ),
    );
  }
}
