import 'package:ecom_app/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'fetch_user.dart';

class FetchUserBloc extends Bloc<FetchUserEvent, FetchUserState> {
  final _authRepository = AuthRepository();
  FetchUserBloc() : super(FetchUserInitialState()) {
    on<FetchUserProfile>(_mapFetchuserProfile);
  }

  void _mapFetchuserProfile(
      FetchUserProfile event, Emitter<FetchUserState> emit) async {
    emit(FetchUserLoadingState());
    // String uid = event.uid;

    // var response = await _authRepository.fetchUserProfile(uid: uid);
    var response = await _authRepository.fetchUserProfile();

    if (response is Map<String, dynamic>?) {
      emit(FetchUserSuccessState(data: response));
    } else {
      emit(FetchUserErrorState(error: response.toString()));
    }
  }
}
