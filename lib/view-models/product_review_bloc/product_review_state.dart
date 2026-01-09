import 'package:equatable/equatable.dart';

abstract class ProductReviewState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductReviewInitial extends ProductReviewState {}

class ProductReviewLoading extends ProductReviewState {}

class ProductReviewSuccess extends ProductReviewState {}

class ProductReviewError extends ProductReviewState {}
