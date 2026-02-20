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

  @override
  List<Object> get props => [review, timeStamp, rating, productId];
}

class DeleteReview extends ProductReviewEvent {
  DeleteReview({required this.reviewId, required this.productID});
  String reviewId;
  String productID;

  @override
  List<Object> get props => [reviewId, productID];
}

class GetLatestSingleReview extends ProductReviewEvent {
  GetLatestSingleReview({required this.productId});
  String productId;
  List<Object> get props => [productId];
}
