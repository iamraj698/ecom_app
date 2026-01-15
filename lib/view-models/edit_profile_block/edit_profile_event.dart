import 'package:equatable/equatable.dart';

abstract class EditProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EditUserInfo extends EditProfileEvent {
  EditUserInfo(
      {required this.uid,
      required this.userName,
      required this.email,
      required this.dob});
  String uid;
  String userName;
  String email;
  DateTime dob;
}
