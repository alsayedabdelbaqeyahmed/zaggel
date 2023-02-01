// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zagel/complete_user_profie/presentattion/cubit/user_profile_cubit.dart';

import '../../../shared_widget/shared_buttons.dart';
import '../../../shared_widget/shared_form_field.dart';

class CompleteProfileFormScreen extends StatelessWidget {
  const CompleteProfileFormScreen({super.key, this.size, this.cubit});
  final BoxConstraints? size;
  final ProfileCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit!.userForm,
      child: Column(
        children: [
          SharedFormField(
            controller: cubit!.userName,
            text: 'User Name',
            validator: ((value) {
              if (value!.isEmpty) {
                return 'User Name can not be empty ';
              }
              return null;
            }),
          ),
          SizedBox(height: 15),
          SharedFormField(
            controller: cubit!.address,
            text: 'User Address',
            validator: ((value) {
              if (value!.isEmpty) {
                return 'UserAddress can not be empty ';
              }
              return null;
            }),
          ),
          SizedBox(height: 15),
          SharedButton(
            size: size,
            press: () async {
              if (cubit!.userForm.currentState!.validate()) {
                await cubit!.completeProfile(context);
              }
            },
            text: 'All Set',
          )
        ],
      ),
    );
  }
}
