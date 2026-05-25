import 'package:ecom_app/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'change_pass.dart';

class ChangePassBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  AuthRepository _authRepository = AuthRepository();
  ChangePassBloc() : super(ChangePasswordInitial()) {
    on<ChangePassword>(_mapChangePassword);
  }
  void _mapChangePassword(
      ChangePassword event, Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordLoading());
    String curretnPassword = event.currentPassword;
    String password = event.password;
    final response =
        await _authRepository.changePassword(curretnPassword, password);
    if (response == "Success") {
      emit(ChangePasswordSuccess());
    } else {
      emit(ChangePasswordError(error: response));
    }
  }
}
