import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/data/repositories/address_repository.dart';
import 'package:ecom_app/models/address_model/address_model.dart';
import 'package:ecom_app/view-models/address_bloc/address.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressRepository _addressRepository = AddressRepository();
  AddressBloc() : super(AddressInitialstate()) {
    on<AddAddressEvent>(_mapAddAddressToFirebase);
    on<FetchAllAddresses>(_mapFetchAllAdresses);
  }

  void _mapAddAddressToFirebase(
      AddAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    String name = event.name;
    int phone = event.phone;
    String area = event.area;
    String city = event.city;
    String state = event.state;
    String country = event.country;
    int pincode = event.pincode;

    final response = await _addressRepository.addAddressToFirebase(
        name: name,
        phone: phone,
        area: area,
        city: city,
        state: state,
        country: country,
        pincode: pincode);
    if (response == "success") {
      add(FetchAllAddresses());
      emit(AddAddressSuccess());
    } else {
      emit(AddressErrorState(error: response));
    }
  }

  void _mapFetchAllAdresses(
      FetchAllAddresses event, Emitter<AddressState> emit) async {
    emit(AddressLoading());

    final response = await _addressRepository.fetchAllAddresses();
    if (response is QuerySnapshot) {
      List<AddressModel> addresses = [];
      for (var address in response.docs) {
        addresses.add(AddressModel.fromFirestore(address));
      }
      emit(AddressFetched(address: addresses));
    } else {
      emit(AddressErrorState(error: response));
    }
  }
}
