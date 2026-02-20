import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/models/review_model/review_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductReviewState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductReviewInitial extends ProductReviewState {}

class ProductReviewLoading extends ProductReviewState {}

class ProductReviewSuccess extends ProductReviewState {}

class ProductDeleteReviewSuccess extends ProductReviewState {}

class ProductReviewError extends ProductReviewState {
  ProductReviewError({required this.error});
  String error;
}

class LatestReviewFetched extends ProductReviewState {
  LatestReviewFetched({required this.review});
  final ReviewModel review;
}

class LatestReviewFetchedZero extends ProductReviewState {
  LatestReviewFetchedZero();
}
