// class AddressModel {
//   final String name;
//   final String phone;
//   final String area;
//   final String city;
//   final String state;
//   final String country;
//   final String pincode;

//   AddressModel({
//     required this.name,
//     required this.phone,
//     required this.area,
//     required this.city,
//     required this.state,
//     required this.country,
//     required this.pincode,
//   });

//   factory AddressModel.fromMap(Map<String, dynamic> map) {
//     return AddressModel(
//       name: map['name'] ?? '',
//       phone: map['phone'] ?? '',
//       area: map['area'] ?? '',
//       city: map['city'] ?? '',
//       state: map['state'] ?? '',
//       country: map['country'] ?? '',
//       pincode: map['pincode'] ?? '',
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'phone': phone,
//       'area': area,
//       'city': city,
//       'state': state,
//       'country': country,
//       'pincode': pincode,
//     };
//   }
// }

class AddressModel {
  final String name;
  final String phone;
  final String area;
  final String city;
  final String state;
  final String country;
  final String pincode;

  AddressModel({
    required this.name,
    required this.phone,
    required this.area,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      area: map['area'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      country: map['country'] ?? '',
      pincode: map['pincode'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'area': area,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
    };
  }
}
