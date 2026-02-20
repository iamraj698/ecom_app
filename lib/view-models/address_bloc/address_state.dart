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
