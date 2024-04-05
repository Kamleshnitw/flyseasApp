import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/location_provider.dart';
import '../../../util/color_resources.dart';
import 'add_new_address_screen.dart';
import 'widget/address_widget.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({Key? key}) : super(key: key);

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {


  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).initAddressList(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Address'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddNewAddressScreen(address: null)));
        },
        backgroundColor: ColorResources.gradientOne,
        child: const Icon(Icons.add),
      ),
      body: Consumer<LocationProvider>(builder: (context,locationProvider,child){
        return ListView.builder(
            itemCount: locationProvider.addressList.length,
            itemBuilder: (context,index){
          return AddressWidget(addressModel: locationProvider.addressList[index], index: index);
        });
      },),
    );
  }
}
