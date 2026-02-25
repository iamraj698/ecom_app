import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  final String id; // Document ID
  final String area;
  final String city;
  final String country;
  final String name;
  final int phone;
  final int pincode;
  final String state;

  AddressModel({
    required this.id,
    required this.area,
    required this.city,
    required this.country,
    required this.name,
    required this.phone,
    required this.pincode,
    required this.state,
  });

  /// Convert Firestore DocumentSnapshot -> AddressModel
  factory AddressModel.fromFirestore(
    DocumentSnapshot doc,
  ) {
    final data = doc.data() as Map<String, dynamic>;

    return AddressModel(
      id: doc.id,
      area: data['area'] ?? '',
      city: data['city'] ?? '',
      country: data['country'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? 0,
      pincode: data['pincode'] ?? 0,
      state: data['state'] ?? '',
    );
  }

  /// Convert AddressModel -> Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'area': area,
      'city': city,
      'country': country,
      'name': name,
      'phone': phone,
      'pincode': pincode,
      'state': state,
    };
  }
}
