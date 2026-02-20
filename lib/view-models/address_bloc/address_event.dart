import "package:equatable/equatable.dart";
import "package:firebase_auth/firebase_auth.dart";

abstract class AddressEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddAddressEvent extends AddressEvent {
  AddAddressEvent(
      {required this.name,
      required this.phone,
      required this.area,
      required this.city,
      required this.state,
      required this.country});
  String name;
  int phone;
  String area;
  String city;
  String state;
  String country;
  @override
  List<Object?> get props => [name, phone, area, city, state, country];
}
