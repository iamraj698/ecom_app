import 'package:ecom_app/components/alert_widget.dart';
import 'package:ecom_app/components/loding_widget.dart';
import 'package:ecom_app/components/product_text_field.dart';
import 'package:ecom_app/components/submit.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/address_bloc/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController areaController = TextEditingController();

  TextEditingController stateController = TextEditingController();

  TextEditingController countryController = TextEditingController();

  TextEditingController pincodeController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        print(state);
        print("dsfsd");
        if (state is AddressLoading) {
          // loadingWidget(context);
        }
        if (state is AddAddressSuccess) {
          navigatorKey.currentState?.pop();
        }
        if (state is AddressErrorState) {
          alertWidget(context, state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Add Address"),
        ),
        body: Padding(
          padding: EdgeInsets.all(width(20)),
          child: SingleChildScrollView(
            child: Column(
              // main column
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // custom product fields

                Container(
                  // padding: EdgeInsets.all(height(10)),
                  decoration: BoxDecoration(
                      // color: const Color.fromARGB(255, 218, 217, 218),
                      // borderRadius: BorderRadius.circular(width(15)),
                      ),
                  child: Column(
                    children: [
                      ProductTextField(
                        controller: nameController,
                        title: "Customer Name",
                      ),
                      SizedBox(height: height(10)),
                      ProductTextField(
                        controller: phoneNumberController,
                        title: "Phone No",
                        inputType: TextInputType.number,
                        inputDigit: true,
                      ),
                      SizedBox(height: height(10)),
                      ProductTextField(
                        controller: areaController,
                        title: "Streat/Area",
                        maxLines: 3,
                      ),
                      SizedBox(height: height(10)),
                      ProductTextField(
                        controller: cityController,
                        title: "City",
                      ),
                      SizedBox(height: height(10)),
                      ProductTextField(
                        controller: stateController,
                        title: "State",
                      ),
                      SizedBox(height: height(10)),
                      ProductTextField(
                        controller: countryController,
                        title: "Country",
                      ),
                      ProductTextField(
                        controller: pincodeController,
                        title: "Pincode",
                        inputType: TextInputType.number,
                        inputDigit: true,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height(10)),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Submit(
            submitText: "Add Product",
            onTap: () {
              if (nameController.text.isEmpty ||
                  areaController.text.isEmpty ||
                  phoneNumberController.text.isEmpty ||
                  stateController.text.isEmpty ||
                  countryController.text.isEmpty ||
                  pincodeController.text.isEmpty) {
                alertWidget(context, "please fill all the required details ");
              } else {
                context.read<AddressBloc>().add(AddAddressEvent(
                    name: nameController.text,
                    phone: int.parse(phoneNumberController.text),
                    area: areaController.text,
                    city: cityController.text,
                    state: stateController.text,
                    country: countryController.text,
                    pincode: int.parse(pincodeController.text)));
              }
            }),
      ),
    );
  }
}
