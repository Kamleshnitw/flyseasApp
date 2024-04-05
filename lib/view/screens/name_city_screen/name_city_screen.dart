import 'package:flutter/material.dart';
import 'package:flyseas/util/app_constants.dart';
import 'package:flyseas/view/screens/home/dashboard_screen.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/progress_dialog.dart';

class NameCityScreen extends StatefulWidget {
  final String phone;
  const NameCityScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<NameCityScreen> createState() => _NameCityScreenState();
}

class _NameCityScreenState extends State<NameCityScreen> {
  TextEditingController nameController = TextEditingController();
  //String _mySelection = "Select City";

  //List data = ["Select City", "Patna", "Varanasi"];
  //String selectedGender = "Select";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getData();
    });
  }

  void getData() async {
    await Provider.of<AuthProvider>(context, listen: false).getCityList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(Images.backgroundImage),
          fit: BoxFit.cover,
        )),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                ),
                const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 60,
                ),
                Image.asset(
                  Images.nameLogoImage,
                  height: 42,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Name and School',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Text(
                  'Select School for Personalise Experience',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Name',
                  ),
                  autofocus: true,
                ),
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),
                Consumer<AuthProvider>(builder: (context,authProvider,child){
                  return  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          contentPadding: EdgeInsets.all(10)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isDense: true,
                          isExpanded: true,
                          hint: const Text('Select School'),
                          items: authProvider.cityNameList.map((item) {
                            print(item);
                            return DropdownMenuItem(
                              child: Text(item),
                              value: item,
                            );
                          }).toList(),
                          onChanged: (String? newVal) {
                            authProvider.updateSelectedCity(newVal!);
                          },
                          value: authProvider.selectedCity,
                        ),
                      ),
                    ),
                  );
                }),


                const SizedBox(
                  height: 30,
                ),
                //Text('data ${widget.phone}'),
                GestureDetector(
                  onTap: () {
                    updateNameCity();
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
          ),
        ),
      ),
    );
  }

  updateNameCity() async {
    String name = nameController.text.toString();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Enter Name'),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if (Provider.of<AuthProvider>(context, listen: false).selectedCity == "Select City") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please Select City'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    Map<String, String> loginData = {};
    loginData['city_id'] = Provider.of<AuthProvider>(context, listen: false).getCityId();
    loginData['name'] = name;
    loginData['phone'] = widget.phone;

    ProgressDialog.showLoadingDialog(context);
    await Provider.of<AuthProvider>(context, listen: false)
        .loginWithPhone(loginData, loginCallback,isOtpVerified: true);
  }

  loginCallback(bool isRoute,String errorMessage) {
    if (isRoute) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.green,
      ));
      //phoneNumberController.clear();
      ProgressDialog.closeLoadingDialog(context);
      Provider.of<AuthProvider>(context, listen: false).savePreferenceData(
          AppConstants.name, nameController.text.toString());
      Provider.of<AuthProvider>(context, listen: false).savePreferenceData(AppConstants.city,
          Provider.of<AuthProvider>(context, listen: false).selectedCity);
      Provider.of<AuthProvider>(context, listen: false).savePreferenceData(AppConstants.cityId,
          Provider.of<AuthProvider>(context, listen: false).getCityId());

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    } else {
      ProgressDialog.closeLoadingDialog(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
    }
  }
}
