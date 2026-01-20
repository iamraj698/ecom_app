import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/data/repositories/product_repository.dart';
import 'package:ecom_app/models/review_model/review_model.dart';
import 'package:ecom_app/view-models/fetch_all_reviews/fetch_all_review_state.dart';

import 'product_review.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductReviewBloc extends Bloc<ProductReviewEvent, ProductReviewState> {
  ProductRepository _productRepository = ProductRepository();
  ProductReviewBloc() : super(ProductReviewInitial()) {
    on<AddReview>(_mapAddReviewToFirebase);
    on<DeleteReview>(_mapDeleteReviewFromFirebase);
    on<GetLatestSingleReview>(_mapFetchLatestReview);
  }

  void _mapAddReviewToFirebase(
      AddReview event, Emitter<ProductReviewState> emit) async {
    String review = event.review;
    String dateTime = event.timeStamp;
    String rating = event.rating;
    String productId = event.productId;

    emit(ProductReviewLoading());

    final response =
        await _productRepository.addReview(review, productId, dateTime, rating);

    if (response is String && response == "success") {
      emit(ProductReviewSuccess());
    } else {
      emit(ProductReviewError(error: response.toString()));
    }
  }

  void _mapDeleteReviewFromFirebase(
      DeleteReview event, Emitter<ProductReviewState> emit) async {
    String reviewID = event.reviewId;
    String productId = event.productID;

    emit(ProductReviewLoading());

    final response = await _productRepository.deleteReview(
        reviewID: reviewID, productId: productId);

    if (response is String && response == "success") {
      emit(ProductDeleteReviewSuccess());
    } else {
      emit(ProductReviewError(error: response.toString()));
    }
  }

  void _mapFetchLatestReview(
      GetLatestSingleReview event, Emitter<ProductReviewState> emit) async {
    String productId = event.productId;
    final response =
        await _productRepository.fetchLatestSingleReview(productID: productId);
    emit(ProductReviewLoading());
    if (response is ReviewModel) {
      emit(LatestReviewFetched(review: response));
    } else if (response is String) {
      FetchReviewError(error: response);
    } else if (response is Null) {
      emit(LatestReviewFetchedZero());
    }
  }
}
