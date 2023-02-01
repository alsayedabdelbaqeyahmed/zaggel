import 'package:flutter/material.dart';
import 'package:zagel/auth_screen/presentation/view/auth_screen.dart';
import 'package:zagel/auth_screen/presentation/view/otp_screen.dart';
import 'package:zagel/complete_user_profie/presentattion/cubit/user_profile_state.dart';
import 'package:zagel/complete_user_profie/presentattion/view/complete_profile_form_screen.dart';
import 'package:zagel/complete_user_profie/presentattion/view/complete_profile_screen.dart';

Map<String, Widget Function(BuildContext context)>? routes = {
  AuthScreen.routesName: (context) => const AuthScreen(),
  OtpScreen.routesName: (context) => const OtpScreen(),
  CompleteUserProfile.routesName: (context) => const CompleteUserProfile(),
};
