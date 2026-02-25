import 'package:ecom_app/models/address_model/address_model.dart';

abstract class AddressState {}

class AddressInitialstate extends AddressState {
  AddressInitialstate();
}

class AddressLoading extends AddressState {
  AddressLoading();
}

class AddAddressSuccess extends AddressState {
  AddAddressSuccess();
}

class DeleteAddressState extends AddressState {
  DeleteAddressState();
}

class AddressErrorState extends AddressState {
  String error;
  AddressErrorState({required this.error});
}

class AddressFetched extends AddressState {
  List<AddressModel>? address;
  AddressFetched({required this.address});
}
