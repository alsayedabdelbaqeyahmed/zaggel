import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:zagel/complete_user_profie/data/user_models.dart';
import 'package:zagel/complete_user_profie/presentattion/cubit/user_profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(CompleteProfileInitState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  final GlobalKey<FormState> userForm = GlobalKey<FormState>();
  final TextEditingController userName = TextEditingController();
  final TextEditingController address = TextEditingController();

  File? selectedImage;
  late String? profileImageUrl;
  late String? sourceofImage;
  final picker = ImagePicker();

  User? getUserInfo() {
    return FirebaseAuth.instance.currentUser;
  }

// take the profile image
  Future pickImage(BuildContext context, BoxConstraints? size) async {
    await selectThesourceofImage(context, size);
    final pickedImage = await picker.pickImage(
      source: sourceofImage == 'Camera'
          ? ImageSource.camera
          : sourceofImage == 'Gallery'
              ? ImageSource.gallery
              : ImageSource.camera,
    );
    if (pickedImage == null) {
      return;
    }

    selectedImage = File(pickedImage.path);
  }

  // upload user profile to firebase storage
  Future<void> addProfileImage() async {
    emit(AddImageInitState());
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('${getUserInfo()!.uid}.jpg');
      await ref.putFile(selectedImage!).whenComplete(() async {
        profileImageUrl = await ref.getDownloadURL();
      });
      emit(AddImageSucessState());
    } catch (e) {
      emit(AddImageErrorState());
      debugPrint(e.toString());
    }
  }

  // add user info name , uid , number , image
  Future<void> completeProfile(BuildContext context) async {
    emit(CompleteProfileInitState());

    try {
      final userModel = UserModel(
        address: address.text,
        userImage: profileImageUrl,
        userId: getUserInfo()!.uid,
        userName: userName.text,
        userPhone: getUserInfo()!.phoneNumber,
      );
      FirebaseFirestore.instance
          .collection('Users')
          .doc(getUserInfo()!.phoneNumber!)
          .set(
            userModel.toJson()!,
          )
          .then(
            (value) => showTopSnackBar(
              Overlay.of(context)!,
              CustomSnackBar.success(
                maxLines: 1,
                message: "Welcome ${userName.text}",
                iconPositionLeft: 50,
                iconRotationAngle: 0,
              ),
              displayDuration: const Duration(seconds: 1),
            ),
          );
      emit(CompleteProfileSucessState());
    } catch (e) {
      debugPrint(e.toString());
      emit(CompleteProfileErrorState());
      // show an error messege to the user
      showTopSnackBar(
          Overlay.of(context)!,
          const CustomSnackBar.error(
            maxLines: 2,
            message: "an error occured please try again later",
            icon: Icon(Icons.error_outline),
            iconPositionLeft: 5,
            iconRotationAngle: 0,
          ),
          displayDuration: const Duration(seconds: 2));
    }
  }

// select the source of the image if gallery or camera
  Future selectThesourceofImage(BuildContext context, BoxConstraints? size) {
    return AwesomeDialog(
      padding: const EdgeInsets.all(10),
      context: context,
      dialogType: DialogType.question,
      body: Column(children: [
        Text(
          'Image Source',
          style:
              TextStyle(color: Colors.black, fontSize: size!.maxHeight * 0.02),
        ),
        SizedBox(height: size.maxHeight * 0.005),
        Text(
          'Camera Or Gallery',
          style: TextStyle(color: Colors.red, fontSize: size.maxHeight * 0.025),
        ),
      ]),
      btnOkText: 'Camera',
      btnOkOnPress: () => sourceofImage = 'Camera',
      btnCancelText: 'Gallery',
      btnCancelOnPress: () => sourceofImage = 'Gallery',
    ).show();
  }

//add user profile image

}
