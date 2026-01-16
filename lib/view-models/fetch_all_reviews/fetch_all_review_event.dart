import 'package:equatable/equatable.dart';

abstract class FetchReviewEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAllReviewEvent extends FetchReviewEvent {
  FetchAllReviewEvent({required this.productId});
  String productId;
}
