import 'product_review.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductReviewBloc extends Bloc<ProductReviewEvent, ProductReviewState> {
  ProductReviewBloc() : super(ProductReviewInitial()) {
    on<AddReview>(_mapAddReviewToFirebase);
  }

  void _mapAddReviewToFirebase(
      AddReview event, Emitter<ProductReviewState> emit) {
    String review = event.review;
    String dateTime = event.timeStamp;
    String rating = event.rating;
    String productId = event.productId;

    print("the values ${review}  ${dateTime}  ${rating} ${productId}");
  }
}
