import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zagel/auth_screen/presentation/cubit/auth_cubit.dart';
import 'package:zagel/auth_screen/presentation/cubit/auth_state.dart';
import 'package:zagel/auth_screen/presentation/view/widget/auth_screen_widget.dart';
import 'package:zagel/styles/string_const.dart';
import 'package:zagel/styles/style_const.dart';

class OtpScreen extends StatelessWidget {
  static const String routesName = '/otpScreen';
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  final argData = ModalRoute.of(context)!.settings.arguments as String;
    //  debugPrint(argData);
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(backgroundColor: Colors.transparent),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (ctx, state) {
          final authCubit = AuthCubit.get(ctx);
          authCubit.context = context;
          return AuthScreenWidget(
            text1: AppStringsConstants.sendOtp,
            text2: AppStringsConstants.enterOtp,
            controller: authCubit.otpNumber,
            formKey: authCubit.otpFformKey,
            validator: (value) {
              debugPrint('lenth is ${value!.length}');
              if (value.isEmpty) {
                return 'please enter a valid otp number';
              }
              // if (value.length < 12) {
              //   return 'please enter your country code\n the your phone nmber';
              // }
              return null;
            },
            press: () async {
              if (authCubit.otpFformKey.currentState!.validate()) {
                await authCubit.signIn(authCubit.otpNumber.text, context);
              }
            },
            text: 'Verify',
          );
        },
      ),
    );
  }
}
