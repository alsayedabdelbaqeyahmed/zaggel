// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, body_might_complete_normally_nullable

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zagel/complete_user_profie/presentattion/cubit/user_profile_cubit.dart';
import 'package:zagel/complete_user_profie/presentattion/cubit/user_profile_state.dart';
import 'package:zagel/complete_user_profie/presentattion/view/complete_profile_form_screen.dart';
import 'package:zagel/shared_widget/shared_buttons.dart';
import 'package:zagel/shared_widget/shared_form_field.dart';
import 'package:zagel/styles/assets.dart';
import 'package:zagel/styles/colors.dart';
import 'package:zagel/styles/string_const.dart';
import 'package:zagel/styles/style_const.dart';

class CompleteUserProfile extends StatelessWidget {
  static const String routesName = '/completeProfileScreen';
  const CompleteUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (BuildContext context, Object? state) {},
        builder: (ctx, state) {
          final profileCubit = ProfileCubit.get(ctx);
          return LayoutBuilder(
            builder: ((context, size) {
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
                        SizedBox(height: size.maxHeight * 0.1),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: size.maxWidth * 0.08,
                            end: size.maxWidth * 0.08,
                            // bottom: size.maxHeight * 0.05,
                          ),
                          child: Container(
                            width: size.maxWidth * 0.9,
                            padding: EdgeInsetsDirectional.only(
                              start: size.maxWidth * 0.05,
                              end: size.maxWidth * 0.05,
                              bottom: size.maxHeight * 0.05,
                            ),
                            decoration: BoxDecoration(
                              //  color: AppColorsConstants.authColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                opacity: 0.8,
                                image: AssetImage(
                                  'assets/images/container.png',
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  // width: size.maxWidth * 0.9,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColorsConstants.authColor,
                                        width: 10,
                                      ),
                                      shape: BoxShape.circle),
                                  child: profileCubit.selectedImage == null
                                      ? CircleAvatar(
                                          radius: size.maxWidth * 0.15,
                                          backgroundImage: AssetImage(
                                            'assets/images/profile_image.png',
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: size.maxWidth * 0.15,
                                          backgroundImage: FileImage(
                                            profileCubit.selectedImage!,
                                          ),
                                        ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        profileCubit
                                            .pickImage(context, size)
                                            .then(
                                              (value) => profileCubit
                                                  .addProfileImage(),
                                            );
                                      },
                                      icon: Icon(
                                        Icons.image_rounded,
                                        color: Color(0xff516091),
                                      ),
                                    ),
                                    Text(
                                      'Edit display image',
                                      style: AppStyleConstants.textStyle(
                                        size: 12,
                                        colr: Color(0xff516091),
                                      ),
                                    ),
                                  ],
                                ),
                                CompleteProfileFormScreen(
                                  size: size,
                                  cubit: profileCubit,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
