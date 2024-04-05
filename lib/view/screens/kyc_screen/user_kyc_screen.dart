import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flyseas/provider/auth_provider.dart';
import 'package:flyseas/provider/profile_provider.dart';
import 'package:flyseas/util/progress_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/profile_response.dart';
import '../../../util/color_resources.dart';

class UserKYCScreen extends StatefulWidget {
  final KycDetails? kycDetails;
  const UserKYCScreen({Key? key,this.kycDetails}) : super(key: key);

  @override
  State<UserKYCScreen> createState() => _UserKYCScreenState();
}

class _UserKYCScreenState extends State<UserKYCScreen> {

  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopAddressController = TextEditingController();
  TextEditingController shopCityController = TextEditingController();
  TextEditingController shopStateController = TextEditingController();
  TextEditingController shopPinCodeController = TextEditingController();
  TextEditingController shopOwnerController = TextEditingController();

  String _myDocSelection = "Select Document";

  List<String> documentList = ["Select Document","GST Certificate",
    "Udyog Aadhar / UDYAM","FSSAI Registration (Food License)","Current Account Cheque","Shop & EStablishment License",
    "Student I'd Card","Other Shop Document","I don’t have any document"];

  FilePickerResult? result;
  PlatformFile? file;

  void pickFiles(String id) async {
    result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'pdf']);
    if (result == null) return;
    file = result!.files.first;
    if (file != null) {
      if (mounted) {
        Provider.of<ProfileProvider>(context, listen: false)
            .updateFileData(id, file!.path.toString());
      }
    }
    setState(() {});
  }

  void imageCapture(String id) async {
    final ImagePicker picker = ImagePicker();
    // Capture a photo
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      if (mounted) {
        Provider.of<ProfileProvider>(context, listen: false)
            .updateFileData(id, photo.path.toString());
      }
      setState(() {});
    }
  }

  showImageChooseBottomSheet(BuildContext context,String id) {
    showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0))),
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * .2,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
                color: Colors.white),
            child: SingleChildScrollView(
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        imageCapture(id);
                      },
                      child: Container(
                        child: Column(
                          children: const [
                            Icon(Icons.camera_alt_outlined, size: 48,),
                            SizedBox(height: 8,),
                            Text('Camera')
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        pickFiles(id);
                      },
                      child: Container(
                        child: Column(
                          children: const [
                            Icon(Icons.image_outlined, size: 48,),
                            SizedBox(height: 8,),
                            Text('Gallery')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    if(widget.kycDetails!=null){
      shopNameController.text = widget.kycDetails!.shopName;
      shopAddressController.text = widget.kycDetails!.shopFullAddress;
      shopOwnerController.text = widget.kycDetails!.ownerName;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: Color(0xFFFFE8F5),
            //height: 120,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.navigate_before),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Complete Shop’s KYC'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: shopNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Shop Name',
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 20,),
                TextField(
                  controller: shopOwnerController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Owner Name',
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 20,),
                TextField(
                  controller: shopAddressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Shop Address',
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 20,),
                TextField(
                  controller: shopCityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Shop City',
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 20,),
                TextField(
                  controller: shopStateController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Shop State',
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 20,),
                TextField(
                  controller: shopPinCodeController,
                  maxLength: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    counterText: "",
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Shop PinCode',
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 20,),
                Visibility(
                  visible: widget.kycDetails!=null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        flex:1,
                        child: Column(
                          children: [
                            Text('Image'),
                            Image.network(widget.kycDetails?.shopFrontImage ?? "",height: 120,),
                          ],
                        )
                    ),
                    Expanded(
                        flex:1,
                        child: Column(
                          children: [
                            Text(widget.kycDetails?.otherDocument ?? ""),
                            Image.network(widget.kycDetails?.otherDocumentFile ?? "",height: 120,),
                          ],
                        )
                    )
                  ],
                )),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text('Upload Image'),
                    ),
                    ElevatedButton(onPressed: (){
                      showImageChooseBottomSheet(context, "shop_front_image");

                    }, style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(ColorResources.gradientOne)
                    ),
                        child: Text('Upload')),
                  ],
                ),
                Text(Provider.of<ProfileProvider>(context, listen: false)
                    .getFileName("shop_front_image")),
                const SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: InputDecorator(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isDense: true,
                        isExpanded: true,
                        items: documentList.map((item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            _myDocSelection = newVal!.toString();
                          });
                          Provider.of<ProfileProvider>(context, listen: false).updateFormValue("other_document", _myDocSelection);
                        },
                        value: _myDocSelection,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                    if(_myDocSelection=="Select Document"){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("First Select Document"),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ));
                    }
                    else{
                      // show upload
                      showImageChooseBottomSheet(context, "other_document_file");
                    }
                }, style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(ColorResources.gradientOne)
                ),
                    child: Text('Upload')),
                Text(Provider.of<ProfileProvider>(context, listen: false)
                    .getFileName("other_document_file")),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    submitData();
                  },
                  child: Container(
                    height: 54,
                    width: MediaQuery.of(context).size.width * .9,
                    margin: EdgeInsets.only(bottom: 40),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorResources.gradientOne,
                            ColorResources.gradientTwo,
                          ]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: ColorResources.WHITE,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  submitData(){
    if(shopNameController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter Shop Name"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if(shopOwnerController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter Shop Owner"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if(shopAddressController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter Shop Address"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if(shopCityController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter Shop City"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if(shopStateController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter Shop State"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if(shopPinCodeController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter Shop PinCode"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if(_myDocSelection=="Select Document"){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Select Document"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if(!Provider.of<ProfileProvider>(context, listen: false).fileData.containsKey("shop_front_image")){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Upload Shop Front Image"),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if(!Provider.of<ProfileProvider>(context, listen: false).fileData.containsKey("other_document_file")){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Upload Document"),
        backgroundColor: Colors.red,
      ));
      return;
    }

    Provider.of<ProfileProvider>(context, listen: false).updateFormValue("shop_name", shopNameController.text.toString());
    Provider.of<ProfileProvider>(context, listen: false).updateFormValue("shop_full_address", shopAddressController.text.toString());
    Provider.of<ProfileProvider>(context, listen: false).updateFormValue("city", shopCityController.text.toString());
    Provider.of<ProfileProvider>(context, listen: false).updateFormValue("state", shopStateController.text.toString());
    Provider.of<ProfileProvider>(context, listen: false).updateFormValue("pincode", shopPinCodeController.text.toString());
    Provider.of<ProfileProvider>(context, listen: false).updateFormValue("owner_name", shopOwnerController.text.toString());

    ProgressDialog.showLoadingDialog(context);
    Provider.of<ProfileProvider>(context, listen: false).
    storeKYCData(Provider.of<AuthProvider>(context, listen: false).getUserToken()).then((value) {
      ProgressDialog.closeLoadingDialog(context);
      if(value['status']){
        Provider.of<ProfileProvider>(context, listen: false).fileData.clear();
        Provider.of<ProfileProvider>(context, listen: false).formValues.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value['message']),
          backgroundColor: Colors.green,
        ));
        //Navigator.pop(context);
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value['message']),
          backgroundColor: Colors.red,
        ));
      }
    });


  }
}
