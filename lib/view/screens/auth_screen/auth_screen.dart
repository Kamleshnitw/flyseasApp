import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyseas/util/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../provider/auth_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/images.dart';
import '../../../util/progress_dialog.dart';
import '../otp_screen/otp_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextStyle defaultStyle = const TextStyle(color: Colors.white, fontSize: 12.0,fontWeight: FontWeight.w500,);
  final TextStyle linkStyle = const TextStyle(color: ColorResources.gradientOne,fontSize: 12.0,fontWeight: FontWeight.w500);

  TextEditingController mobileNumberController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage(Images.backgroundImage),
          fit: BoxFit.cover,
          )
        ),
        child: Stack(
          children: [
            //Image.asset(Images.backgroundImage,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,),
            Padding(
              padding: const EdgeInsets.all(34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,),
                  Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),
                  SizedBox(height: 60,),
                  Image.asset(Images.nameLogoImage,height: 50,),
                  SizedBox(height: 30,),
                  Text('Enter mobile number',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w600),),
                  const SizedBox(height: 2,),
                  Text('We’ll send an OTP for verification',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),),
                  SizedBox(height: 40,),
                  TextField(
                    controller: mobileNumberController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      counterText: "",
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter Phone  Number',
                      prefix: Padding(
                        padding: const EdgeInsets.only(right: 8.0,left: 16),
                        child: Text('+91'),
                      ),
                      prefixStyle: TextStyle(color: Colors.black)
                    ),
                    autofocus: true,
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      verifyNumber();
                    },
                    child: Container(
                      height: 54,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        gradient:  const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              ColorResources.gradientOne,
                              ColorResources.gradientTwo,
                            ]
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(child: Text('Continue',style: TextStyle(color: ColorResources.WHITE,fontSize: 13,fontWeight: FontWeight.w600),)),
                    ),
                  ),

                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 50),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                    style: defaultStyle,
                    children: [
                      const TextSpan(text: 'By continuing, you agree to our \n'),
                      TextSpan(
                          text: 'Terms of Service',
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _launchUrl('https://flyseas.in/');
                            }),
                      const TextSpan(text: ' & '),
                      TextSpan(
                          text: 'Privacy Policy',
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _launchUrl('https://flyseas.in/');
                            }),
                    ]
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

   verifyNumber() async{
    String mobileNumber= mobileNumberController.text.toString();
    if(mobileNumber.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Phone Number Required'),
        backgroundColor: Colors.red,
      ));
      return;
    }
    else if(mobileNumber.length!=10){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid Phone Number'),
        backgroundColor: Colors.red,
      ));
      return;
    }
    Map<String,String> loginData = {};
    loginData['phone'] = mobileNumber;
    ProgressDialog.showLoadingDialog(context);
    await Provider.of<AuthProvider>(context, listen: false).loginWithPhone(loginData, loginCallback);

  }

  loginCallback(bool isRoute,String errorMessage){
    if(isRoute){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.green,
      ));
      //phoneNumberController.clear();
      ProgressDialog.closeLoadingDialog(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OTPScreen(mobileNumber: mobileNumberController.text.toString())));
    }
    else{
      ProgressDialog.closeLoadingDialog(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
    }

  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }
}
