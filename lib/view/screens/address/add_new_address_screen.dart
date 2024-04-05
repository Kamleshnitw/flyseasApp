import 'package:flutter/material.dart';
import 'package:flyseas/util/custom_themes.dart';


import 'package:provider/provider.dart';

import '../../../data/model/response/address_list_response.dart';
import '../../../provider/location_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/custom_snackbar.dart';
import '../../../util/dimensions.dart';


class AddNewAddressScreen extends StatefulWidget {
  final bool isEnableUpdate;
  final bool fromCheckout;
  final Address? address;
  AddNewAddressScreen({this.isEnableUpdate = false, required this.address, this.fromCheckout = false});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final TextEditingController _contactPersonNameController = TextEditingController();
  final TextEditingController _contactPersonNumberController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final FocusNode _addressNode = FocusNode();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _numberNode = FocusNode();
  final FocusNode _cityNode = FocusNode();
  final FocusNode _stateNode = FocusNode();
  final FocusNode _countryNode = FocusNode();
  final FocusNode _zipNode = FocusNode();

  bool _updateAddress = true;



  @override
  void initState() {
    super.initState();

    Provider.of<LocationProvider>(context, listen: false).initializeAllAddressType(context: context);
    Provider.of<LocationProvider>(context, listen: false).updateAddressStatusMessae(message: '');
    Provider.of<LocationProvider>(context, listen: false).updateErrorMessage(message: '');
    if (widget.isEnableUpdate && widget.address != null) {
      _updateAddress = false;
      //_contactPersonNameController.text = widget.address!.name;
      //_contactPersonNumberController.text = widget.address!.phone;

      Provider.of<LocationProvider>(context, listen: false).locationController.text = widget.address!.address;
      Provider.of<LocationProvider>(context, listen: false).countryController.text = widget.address!.country;
      Provider.of<LocationProvider>(context, listen: false).stateController.text = widget.address!.stateName;
      Provider.of<LocationProvider>(context, listen: false).cityController.text = widget.address!.cityName;
      //Provider.of<LocationProvider>(context, listen: false).stateId = widget.address!.state.id.toString();
      //Provider.of<LocationProvider>(context, listen: false).cityId = widget.address!.city.id.toString();

      _pinCodeController.text = widget.address!.pincode;

      /*if (widget.address!.addressType == 'Home') {
        Provider.of<LocationProvider>(context, listen: false).updateAddressIndex(0, false);
      } else if (widget.address!.addressType == 'Workplace') {
        Provider.of<LocationProvider>(context, listen: false).updateAddressIndex(1, false);
      } else {
        Provider.of<LocationProvider>(context, listen: false).updateAddressIndex(2, false);
      }*/
    }else {
      /*if(Provider.of<ProfileProvider>(context, listen: false).userInfoModel!=null){
        _contactPersonNameController.text = '${Provider.of<ProfileProvider>(context, listen: false).userInfoModel.fName ?? ''}'
            ' ${Provider.of<ProfileProvider>(context, listen: false).userInfoModel.lName ?? ''}';
        _contactPersonNumberController.text = Provider.of<ProfileProvider>(context, listen: false).userInfoModel.phone ?? '';
      }*/

    }
  }

  @override
  Widget build(BuildContext context) {
    //Provider.of<ProfileProvider>(context, listen: false).initAddressList(context);
    //Provider.of<ProfileProvider>(context, listen: false).initAddressTypeList(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEnableUpdate ? 'Update Address' : 'Add New Address'),
      ),
      body: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          return Stack(
            children: [
              ListView(
               padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
               children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 5,),
                   child: Text(
                     'Enter Name',
                     style: Theme.of(context).textTheme.headline3?.copyWith(color: ColorResources.getHint(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                   ),
                 ),
                 // for Address Field
                 SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                 TextField(
                   keyboardType: TextInputType.streetAddress,
                   textInputAction: TextInputAction.next,
                   focusNode: _addressNode,
                   decoration: const InputDecoration(
                       hintText: "Name",
                       border: OutlineInputBorder()
                   ),
                   onSubmitted: (value){
                     FocusScope.of(context).requestFocus(_nameNode);
                   },
                   controller: locationProvider.locationController,
                 ),
                 SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                 Text(
                   'Enter Class & Roll No',
                   style: robotoRegular.copyWith(color: ColorResources.getHint(context)),
                 ),
                 SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                 TextField(
                   keyboardType: TextInputType.text,
                   textInputAction: TextInputAction.next,
                   focusNode: _zipNode,
                   decoration:  InputDecoration(
                       hintText: "Enter Class & Roll No",
                       border: OutlineInputBorder(),
                       counterText: "",
                       errorText: locationProvider.isPinCodeFound.isNotEmpty ? locationProvider.isPinCodeFound : null
                   ),
                   onSubmitted: (value){
                     FocusScope.of(context).requestFocus(_nameNode);
                   },
                   onChanged: (value){

                   },
                   controller: _pinCodeController,
                 ),
                 SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                 Text(
                   'City',
                   style: robotoRegular.copyWith(color: ColorResources.getHint(context)),
                 ),
                 SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                 TextField(
                   keyboardType: TextInputType.streetAddress,
                   textInputAction: TextInputAction.next,
                   focusNode: _stateNode,
                   decoration: const InputDecoration(
                       hintText: "City",
                       border: OutlineInputBorder()
                   ),
                   controller: locationProvider.cityController,
                 ),
                 SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                 Text(
                   'State',
                   style: robotoRegular.copyWith(color: ColorResources.getHint(context)),
                 ),
                 SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                 TextField(
                   keyboardType: TextInputType.streetAddress,
                   textInputAction: TextInputAction.next,
                   focusNode: _countryNode,
                   decoration: const InputDecoration(
                       hintText: "State",
                       border: OutlineInputBorder()
                   ),
                   controller: locationProvider.stateController,
                 ),
                 SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                 /*Text(
                   'Country',
                   style: robotoRegular.copyWith(color: ColorResources.getHint(context)),
                 ),
                 SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                 TextField(
                   keyboardType: TextInputType.streetAddress,
                   textInputAction: TextInputAction.next,
                   decoration: const InputDecoration(
                       hintText: "Country",
                       border: OutlineInputBorder()
                   ),
                   controller: locationProvider.countryController,
                 ),*/
                // const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                 locationProvider.addressStatusMessage != null
                     ? Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     locationProvider.addressStatusMessage?.isNotEmpty==true ?
                     CircleAvatar(backgroundColor: Colors.green, radius: 5) : SizedBox.shrink(),
                     SizedBox(width: 8),
                     Expanded(
                       child: Text(locationProvider.addressStatusMessage ?? "",
                         style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Colors.green, height: 1),
                       ),
                     )
                   ],
                 )
                     : Row(crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     locationProvider.errorMessage.length > 0
                         ? CircleAvatar(backgroundColor: Theme.of(context).primaryColor, radius: 5) : SizedBox.shrink(),
                     SizedBox(width: 8),
                     Expanded(
                       child: Text(locationProvider.errorMessage,
                         style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Theme.of(context).primaryColor, height: 1),
                       ),
                     )
                   ],
                 ),
                 SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT *4)
               ],
             ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .95,
                    height: 50.0,
                    margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: !locationProvider.isLoading ? ElevatedButton(
                      child: Text(widget.isEnableUpdate ? 'Update Address' : 'Save Address'),
                      onPressed: /*locationProvider.loading ? null :*/ () {
                        if(locationProvider.stateController.text.isEmpty){
                          showCustomSnackBar("State Required", context);
                          return;
                        } else if(_pinCodeController.text.isEmpty){
                          showCustomSnackBar("Pincode Required", context);
                          return;
                        } else if(locationProvider.locationController.text.isEmpty){
                          showCustomSnackBar("Address Required", context);
                          return;
                        }else if(locationProvider.cityController.text.isEmpty){
                          showCustomSnackBar("City Required", context);
                          return;
                        }

                        Map<String,String> addressData = {};
                        //addressData['address_type'] = locationProvider.getAllAddressType[locationProvider.selectAddressIndex];
                        //addressData['name'] = _contactPersonNameController.text;
                        //addressData['phone'] = _contactPersonNumberController.text;
                        addressData['city'] = locationProvider.cityController.text;
                        addressData['state'] = locationProvider.stateController.text;
                        addressData['country'] = "India";
                        addressData['pincode'] = _pinCodeController.text;
                        addressData['address'] = locationProvider.locationController.text;
                      if (widget.isEnableUpdate) {
                        //addressData['id'] = widget.address!.id.toString();
                        // addressModel.method = 'put';
                        locationProvider.updateAddress(context, addressModel: addressData,id: widget.address!.id).then((value) {
                          if(value.isSuccess){
                            clearFields();
                            Navigator.pop(context);
                          }
                        });
                      } else {
                        locationProvider.addAddress(addressData, context).then((value) {
                          if (value.isSuccess) {
                            //Provider.of<ProfileProvider>(context, listen: false).initAddressList(context);
                            clearFields();
                            Navigator.pop(context);
                            if (widget.fromCheckout) {
                              //Provider.of<ProfileProvider>(context, listen: false).initAddressList(context);
                              //Provider.of<OrderProvider>(context, listen: false).setAddressIndex(-1);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.message), duration: Duration(milliseconds: 600), backgroundColor: Colors.green));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.message), duration: Duration(milliseconds: 600), backgroundColor: Colors.red));
                          }
                        });
                      }
                      },
                    )
                        : Center(
                        child: CircularProgressIndicator(
                          valueColor:  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                        )),
                  ))
            ],
          );
        },
      ),
    );
  }

  void clearFields(){
    _contactPersonNameController.text = '';
    _contactPersonNumberController.text = '';
    Provider.of<LocationProvider>(context, listen: false).locationController.text = '';
    Provider.of<LocationProvider>(context, listen: false).countryController.text = '';
    Provider.of<LocationProvider>(context, listen: false).stateController.text = '';
    Provider.of<LocationProvider>(context, listen: false).cityController.text = '';
    Provider.of<LocationProvider>(context, listen: false).stateId = '';
    Provider.of<LocationProvider>(context, listen: false).cityId = '';
  }



}
