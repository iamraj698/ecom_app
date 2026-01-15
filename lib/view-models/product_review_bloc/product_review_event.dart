import 'package:equatable/equatable.dart';

abstract class ProductReviewEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddReview extends ProductReviewEvent {
  AddReview({
    required this.review,
    // required this.userId,
    required this.timeStamp,
    required this.productId,
    required this.rating,
  });
  String review;
  // String userId;
  String timeStamp;
  String rating;
  String productId;
}

class ViewReview extends ProductReviewEvent {}
