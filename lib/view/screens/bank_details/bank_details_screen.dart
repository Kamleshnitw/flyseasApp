import 'package:flutter/material.dart';
import 'package:flyseas/data/model/response/profile_response.dart';
import 'package:flyseas/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../util/color_resources.dart';

class BankDetailsScreen extends StatefulWidget {
  final BankDetail? bankDetail;
  const BankDetailsScreen({Key? key,this.bankDetail}) : super(key: key);

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {

  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountHolderNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.bankDetail!=null){
      bankNameController.text = widget.bankDetail!.bankName;
      branchNameController.text = widget.bankDetail!.address;
      ifscController.text = widget.bankDetail!.ifscCode;
      accountNumberController.text = widget.bankDetail!.accountNumber;
      accountHolderNameController.text = widget.bankDetail!.accountHolderName;
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bank Detail'),backgroundColor: ColorResources.gradientOne,),
      backgroundColor: const Color(0xFFFFE8F5),
      body: Consumer<ProfileProvider>(builder: (context,profileProvider,child){
        return Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                child: Text('Bank Name'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Bank Name';
                    }
                    return null;
                  },
                  controller: bankNameController,
                  decoration: const InputDecoration(
                    hintText: "Bank Name",
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 10)
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                child: Text('Branch Name'),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Branch Name';
                    }
                    return null;
                  },
                  controller: branchNameController,
                  decoration: const InputDecoration(
                      hintText: "Branch Name",
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 10)
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                child: Text('IFSC Code'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter IFSC Code';
                    }
                    return null;
                  },
                  controller:  ifscController,
                  decoration: const InputDecoration(
                      hintText: "IFSC Code",
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 10)
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                child: Text('Account Number'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Account Number';
                    }
                    return null;
                  },
                  controller: accountNumberController,
                  decoration: const InputDecoration(
                      hintText: "Account Number",
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 10)
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                child: Text('Account Holder Name'),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                  controller: accountHolderNameController,
                  decoration: const InputDecoration(
                      hintText: "Account Holder Name",
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 10)
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  height: 55,
                  child: profileProvider.isBankDetailUpdating ? const Center(
                    child: CircularProgressIndicator(),
                  ) : ElevatedButton(onPressed: (){
                    if (_formKey.currentState!.validate()) {
                          Map<String,String> bankDetails = {};
                          bankDetails['bank_name'] = bankNameController.text.toString();
                          bankDetails['address'] = branchNameController.text.toString();
                          bankDetails['ifsc_code'] = ifscController.text.toString();
                          bankDetails['account_number'] = accountNumberController.text.toString();
                          bankDetails['account_holder_name'] = accountHolderNameController.text.toString();
                          profileProvider.storeBankDetail(bankDetails,isUpdate: widget.bankDetail!=null).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(value.message),
                              backgroundColor: value.isSuccess ? Colors.green:Colors.red,
                            ));
                          });
                    }
                  }, child: const Text('Update')))
            ],
          ),
        );
      },),
    );
  }
}
