import 'package:equatable/equatable.dart';

abstract class FetchUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUserProfile extends FetchUserEvent {
  // FetchUserProfile({required this.uid});
  // String uid;
}
