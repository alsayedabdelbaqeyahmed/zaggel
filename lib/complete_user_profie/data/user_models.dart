import 'package:zagel/styles/string_const.dart';

class UserModel {
  final String? userId;
  final String? userName;
  final String? userImage;
  final String? userPhone;
  final String? address;

  UserModel({
    this.userId,
    this.userName,
    this.userImage,
    this.userPhone,
    this.address,
  });

  Map<String, dynamic>? toJson() {
    return {
      AppStringsConstants.userId: userId,
      AppStringsConstants.userName: userName,
      AppStringsConstants.userImage: userImage,
      AppStringsConstants.userPhone: userPhone,
      AppStringsConstants.address: address,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        userId: map[AppStringsConstants.userId],
        userName: map[AppStringsConstants.userName],
        userImage: map[AppStringsConstants.userImage],
        userPhone: map[AppStringsConstants.userPhone],
        address: map[AppStringsConstants.address]);
  }
}
