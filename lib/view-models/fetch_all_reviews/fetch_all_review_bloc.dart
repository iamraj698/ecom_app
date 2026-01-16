import 'package:ecom_app/data/repositories/product_repository.dart';
import 'package:ecom_app/models/review_model/review_model.dart';
import 'fetch_review.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchAllReviewBloc extends Bloc<FetchReviewEvent, FetchReviewState> {
  ProductRepository _productRepository = ProductRepository();
  FetchAllReviewBloc() : super(FetchReviewInitial()) {
    on<FetchAllReviewEvent>(_mapFetchAllReviews);
  }

  void _mapFetchAllReviews(
      FetchAllReviewEvent event, Emitter<FetchReviewState> emit) async {
    String productId = event.productId;
    final stream = await emit.forEach(
      _productRepository.fetchAllReviews(productId: productId),
      onData: (data) {
        // print("here 1");
        List<ReviewModel> reviews = data.docs.map((doc) {
          return ReviewModel.fromDocumentSnapshot(doc);
        }).toList();
        print("review from bloc");
        for (var rev in reviews) {
          print(rev.id + rev.addedOn);
        }
        return FetchReviewLoaded(reviews: reviews);
      },
      onError: (error, stackTrace) {
        return FetchReviewError(error: error.toString());
      },
    );

    // print("bloc______________");
    // final snapshot = _productRepository.fetchAllReviews(productId: productId);
  }
}
