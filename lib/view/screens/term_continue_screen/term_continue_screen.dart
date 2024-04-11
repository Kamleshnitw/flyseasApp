import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyseas/util/app_constants.dart';
import 'package:flyseas/util/color_resources.dart';
import 'package:flyseas/util/custom_themes.dart';
import 'package:flyseas/util/dimensions.dart';
import 'package:flyseas/util/images.dart';
import 'package:flyseas/view/screens/auth_screen/auth_screen.dart';
import 'package:flyseas/view/screens/otp_screen/otp_screen.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';
import '../../../util/progress_dialog.dart';

class TermContinueScreen extends StatefulWidget {
  const TermContinueScreen({Key? key}) : super(key: key);

  @override
  State<TermContinueScreen> createState() => _TermContinueScreenState();
}

class _TermContinueScreenState extends State<TermContinueScreen> {
  final TextStyle defaultStyle = const TextStyle(color: Color(0xFF959595), fontSize: 8.0);

  final TextStyle linkStyle = const TextStyle(color: Color(0xFF3F92DB),fontSize: 8,decoration: TextDecoration.underline);

  String _mobileNumber = '';

  List<SimCard> _simCard = <SimCard>[];

  @override
  void initState() {
    super.initState();
    /*MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });*/

    //initMobileNumberState();
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      String text = (await MobileNumber.mobileNumber)!.replaceAll(" ", '');
      if(text.length>10){
        _mobileNumber = text.substring(2,text.length);
      }else{
      _mobileNumber = text;
      }
      _simCard = (await MobileNumber.getSimCards)!;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backgroundImage,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,),
          Container(
            // width: MediaQuery.of(context).size.width,
            
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .2,left: MediaQuery.of(context).size.width*.26),
              child: Image.asset(Images.splashLogo,fit: BoxFit.contain,width: 200,)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * .45,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.PADDING_SIZE_DEFAULT),topRight: Radius.circular(Dimensions.PADDING_SIZE_DEFAULT)),
                color: ColorResources.WHITE
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_SMALL),
                child: ListView(
                  children: [
                    const Text('Hi, Welcome to ${AppConstants.appName}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                    const SizedBox(height: 6,),
                    const Text('To get started, please verify mobile number',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
                    const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AuthScreen()));
                       /* if(_mobileNumber.isNotEmpty){
                          loginUserWithPhone();
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Mobile Number Not Available"), backgroundColor: Colors.red));
                        }*/
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              ColorResources.gradientOne,
                              ColorResources.gradientTwo,
                            ]
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        //CONTINUE WITH $_mobileNumber
                        child:  const Center(child: Text('Proceed',style: TextStyle(color: ColorResources.WHITE,fontSize: 12,fontWeight: FontWeight.w500),)),
                      ),
                    ),
                    const SizedBox(height: 4,),
                    /*Center(child: TextButton(onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AuthScreen()));
                    }, child: const Text('USE ANOTHER NUMBER',style: TextStyle(color: Color(0xFF9595959),fontSize: 12,fontWeight: FontWeight.w400),))),
                   */
                    Container(color: Colors.black26,height: 1,),
                    const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      child: RichText(text: TextSpan(
                          style: defaultStyle,
                          children: [
                            const TextSpan(text: 'By continuing you consent to share your Truecaller profile information with Flyseas, and agree to Flyseas’s privacy policy '),
                            TextSpan(
                                text: 'privacy policy',
                                style: linkStyle,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {

                                  }),
                            const TextSpan(text: ' and '),
                            TextSpan(
                                text: 'terms of service.',
                                style: linkStyle,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {

                                  }),
                          ]
                      )),
                    ),
                    const SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Instant Verification by',style: TextStyle(fontSize: 10),),
                        Image.asset(Images.trueCallerLogo,height: 14,),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  loginUserWithPhone () async{
    /*if(_mobileNumber.length>12){
      _mobileNumber = _mobileNumber.substring(2,_mobileNumber.length);
    }*/

    if(_mobileNumber.length!=10){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid Phone Number'),
        backgroundColor: Colors.red,
      ));
      return;
    }
    Map<String,String> loginData = {};
    loginData['phone'] = _mobileNumber;

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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OTPScreen(mobileNumber: _mobileNumber)));
    }
    else{
      ProgressDialog.closeLoadingDialog(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
    }

  }
}
