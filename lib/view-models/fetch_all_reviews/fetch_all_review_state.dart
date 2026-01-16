import 'package:ecom_app/models/review_model/review_model.dart';
import 'package:equatable/equatable.dart';

abstract class FetchReviewState extends Equatable {
  const FetchReviewState();
  @override
  List<Object> get props => [];
}

class FetchReviewInitial extends FetchReviewState {}

class FetchReviewLoading extends FetchReviewState {}

class FetchReviewLoaded extends FetchReviewState {
  List<ReviewModel> reviews;
  FetchReviewLoaded({required this.reviews});
  @override
  List<Object> get props => [reviews];
}

class FetchReviewError extends FetchReviewState {
  FetchReviewError({required this.error});
  String error;
  List<Object> get props => [error];
}
