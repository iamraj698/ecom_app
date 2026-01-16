import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String id;
  final String addedOn;
  final String rating;
  final String review;
  final String userEmail;
  final String userId;
  final String userName;

  ReviewModel({
    required this.id,
    required this.addedOn,
    required this.rating,
    required this.review,
    required this.userEmail,
    required this.userId,
    required this.userName,
  });

  /// 🔥 From Firestore DocumentSnapshot
  factory ReviewModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;

    return ReviewModel(
      id: doc.id,
      addedOn: data['addedOn'] ?? '',
      rating: data['rating'] ?? '',
      review: data['review'] ?? '',
      userEmail: data['userEmail'] ?? '',
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
    );
  }

  /// 🔁 To Firestore
  Map<String, dynamic> toMap() {
    return {
      'addedOn': addedOn,
      'rating': rating,
      'review': review,
      'userEmail': userEmail,
      'userId': userId,
      'userName': userName,
    };
  }
}
