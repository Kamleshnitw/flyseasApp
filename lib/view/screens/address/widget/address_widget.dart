import 'package:flutter/material.dart';
import 'package:flyseas/util/custom_themes.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/response/address_list_response.dart';
import '../../../../provider/location_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../add_new_address_screen.dart';


class AddressWidget extends StatelessWidget {

  final Address addressModel;
  final int index;
  AddressWidget({required this.addressModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      child: InkWell(
        onTap: () {
          if(addressModel != null) {
            //Navigator.push(context, MaterialPageRoute(builder: (_) => MapWidget(address: addressModel)));
          }
        },
        child: Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            //color: ColorResources.getGainsWhite(context),
            boxShadow: [
              BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 200] ?? Colors.black26, spreadRadius: 0.2, blurRadius: 0.5)
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(addressModel.pincode,
                                style: robotoRegular.copyWith(color: Colors.black, fontWeight: FontWeight.w700, fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                              ),
                              const SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                              Row(
                                children: [
                                  Icon(Icons.location_on, color: Theme.of(context).primaryColor, size: 16),
                                  const SizedBox(width: Dimensions.MARGIN_SIZE_DEFAULT,),
                                  Expanded(
                                    child: Text(
                                      "${addressModel.address} ${addressModel.cityName} ${addressModel.stateName}",
                                      style: robotoRegular.copyWith(color: ColorResources.getTextTitle(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    padding: EdgeInsets.all(0),
                    onSelected: (String result) {
                      if (result == 'delete') {
                        showDialog(context: context, barrierDismissible: false, builder: (context) => Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                          ),
                        ));
                        Provider.of<LocationProvider>(context, listen: false).deleteUserAddressByID(addressModel.id, index,
                                (bool isSuccessful, String message) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: isSuccessful ? Colors.green : Colors.red,
                                content: Text(message),
                              ));
                            });
                      } else {
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddNewAddressScreen(isEnableUpdate: true, address: addressModel,fromCheckout: false,)));
                      }
                    },
                    itemBuilder: (BuildContext c) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit', style: robotoRegular),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete', style: robotoRegular),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
