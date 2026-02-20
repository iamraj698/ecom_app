import 'package:ecom_app/view-models/address_bloc/address.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitialstate()) {
    on<AddAddressEvent>(_mapAddAddressToFirebase);
  }

  void _mapAddAddressToFirebase(
      AddAddressEvent event, Emitter<AddressState> emit) async {

        
      }
}
