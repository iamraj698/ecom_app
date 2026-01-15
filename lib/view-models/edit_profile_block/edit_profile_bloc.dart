import 'package:ecom_app/data/repositories/auth_repository.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/view-models/edit_profile_block/edit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final _authRepository = AuthRepository();
  EditProfileBloc() : super(EditProfileInitialState()) {
    on<EditUserInfo>(_mapEditUserProfile);
  }

  void _mapEditUserProfile(
      EditUserInfo event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoadingState());
    String uid = event.uid;
    String userName = event.userName;
    String email = event.email;
    DateTime dob = event.dob;
    String sDob = "${dob.day}-${dob.month}-${dob.year}";

    var response = await _authRepository.updateUserProfile(
      uid: uid,
      dob: sDob,
      email: email,
      name: userName,
    );

    if (response == "success") {
      emit(EditProfileSuccessState());
      navigatorKey.currentState
          ?.pushReplacementNamed(RouteNames.homepage);
    } else {
      emit(EditProfileErrorState(error: response.toString()));
    }

    // print(userName + " " + sDob + "  " + email);
    // if (response is Map<String, dynamic>?) {
    //   emit(FetchUserSuccessState(data: response));
    // } else {
    //   emit(FetchUserErrorState(error: response.toString()));
    // }
  }
}
