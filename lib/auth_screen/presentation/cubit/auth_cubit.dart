// ignore_for_file: empty_catches, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:zagel/auth_screen/presentation/cubit/auth_state.dart';
import 'package:zagel/auth_screen/presentation/view/otp_screen.dart';
import 'package:zagel/complete_user_profie/presentattion/view/complete_profile_screen.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController otpNumber = TextEditingController();
  final GlobalKey<FormState> autFformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otpFformKey = GlobalKey<FormState>();
  late String? verificationId;
  late String? userId;
  late BuildContext? context;
  final auth = FirebaseAuth.instance;

  Future<void> authWithPhoneNumber(BuildContext context,
      {String? phone}) async {
    try {
      emit(AuthInitialState());
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber.text,
        verificationCompleted: ((phoneAuthCredential) async {
          // if the code is input auto without user
          await auth.signInWithCredential(phoneAuthCredential).then(
                (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                  CompleteUserProfile.routesName,
                  (route) => false,
                ),
              );
          emit(AuthSucessstate());
        }),
        // if the process is failed
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {}
  }

// when the code is sent to userphone
  // used to set the verification id

  void codeSent(String verificationId, int? resendToken) async {
    this.verificationId = verificationId;
    emit(AuthPhoneAcceptedstate());
    Navigator.of(context!).pushReplacementNamed(OtpScreen.routesName);
  }

// if the verification field
  void verificationFailed(FirebaseAuthException e) {
    if (e.code == "invalid-phone-number") {
      showTopSnackBar(
          Overlay.of(context!)!,
          const CustomSnackBar.error(
            maxLines: 4,
            message:
                "please enter a valid phone number\n the number must contain \n {+}{country code}{phone number}",
            icon: Icon(Icons.error),
            iconPositionLeft: 5,
            iconRotationAngle: 0,
          ),
          displayDuration: const Duration(seconds: 2));
    }
    emit(AuthErrorState());
    debugPrint('phone number is ${e.code}');
  }

// enter the otp code to complete sign in process
  Future<void> signIn(String otpCode, BuildContext context) async {
    final creditional = PhoneAuthProvider.credential(
        verificationId: verificationId!, smsCode: otpCode);

    await auth.signInWithCredential(creditional).then(
          (value) => Navigator.of(context).pushNamedAndRemoveUntil(
            CompleteUserProfile.routesName,
            (route) => false,
          ),
        );
  }
}
