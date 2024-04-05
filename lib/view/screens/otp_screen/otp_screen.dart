import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flyseas/util/app_constants.dart';
import 'package:flyseas/util/color_resources.dart';
import 'package:flyseas/view/screens/name_city_screen/name_city_screen.dart';
import 'package:flyseas/view/screens/user_detail_screen/user_detail_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../home/dashboard_screen.dart';

class OTPScreen extends StatefulWidget {
  final String mobileNumber;
  //final String token;
  const OTPScreen({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  bool hasError = false;
  String currentText = "";
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();


  @override
  void initState() {
    super.initState();

    if(mounted){
      //send OTP
      Provider.of<AuthProvider>(context,listen: false).startTimer();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(Images.backgroundImage,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,),
          Padding(
            padding: const EdgeInsets.all(34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,),
                Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),
                SizedBox(height: 60,),
                Image.asset(Images.nameLogoImage,height: 42,),
                SizedBox(height: 30,),
                const Text('OTP Verification',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w600),),
                const SizedBox(height: 2,),
                Text('OTP has been sent to +91 ${widget.mobileNumber}',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),),
                const SizedBox(height: 30,),
                Expanded(
                  child: PinCodeTextField(
                    //backgroundColor: Colors.white,
                    appContext: context,
                    pastedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    textStyle: TextStyle(color: Colors.white),
                    obscureText: false,
                    // obscuringCharacter: '*',
                    // obscuringWidget: const Text(
                    //   "*",
                    //   style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      /*if (v.length < 3) {
                                      return "I'm from validator";
                                    } else {
                                      return null;
                                    }*/
                      return null;
                    },
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        fieldHeight: 54,
                        fieldWidth: 45,
                        activeFillColor: hasError ? Colors.red : ColorResources.gradientOne,
                        selectedFillColor: Colors.white,
                        inactiveColor: ColorResources.gradientTwo,
                        selectedColor: ColorResources.gradientTwo,
                        inactiveFillColor: ColorResources.WHITE,
                        activeColor: ColorResources.gradientTwo,
                        disabledColor: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    animationDuration: const Duration(milliseconds: 100),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {},
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      //print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .5),
            child: Consumer<AuthProvider>(builder: (context,authProvider,child){
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20,),
                    Text(
                      "00:${authProvider.start<10?'0${authProvider.start}':'${authProvider.start}'}",
                      style: const TextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 24,),
                    Visibility(
                        visible: authProvider.start==0,
                      child: const Text(
                        "Din’t get it? ",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Visibility(
                      visible: authProvider.start==0,
                      child: TextButton(
                        onPressed: () {
                            authProvider.restartTimer();
                            Map<String,String> loginData = {};
                            loginData['phone'] = widget.mobileNumber;
                            authProvider.loginWithPhone(loginData, loginCallback);
                        },
                        child: const Text(
                          "Resend OTP (SMS)",
                          style: TextStyle(
                              color: Color(0x50FFFFFF),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,decoration: TextDecoration.underline),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: (){
                verifyOTP();
              },
              child: Container(
                height: 54,
                width: MediaQuery.of(context).size.width * .9,
                margin: EdgeInsets.only(bottom: 40),
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
                child: const Center(child: Text('Verify',style: TextStyle(color: ColorResources.WHITE,fontSize: 14,fontWeight: FontWeight.w700),)),
              ),
            ),
          )
        ],
      ),
    );
  }

  verifyOTP() {
    if(currentText.length==6){
      Provider.of<AuthProvider>(context,listen: false).verifyOTP(widget.mobileNumber, currentText).then((value) {
        if(value){
          Provider.of<AuthProvider>(context,listen: false).savePreferenceData(AppConstants.phone,widget.mobileNumber);
          //Provider.of<AuthProvider>(context,listen: false).saveToken(widget.token);
          var authProvider = Provider.of<AuthProvider>(context,listen: false);
          if(authProvider.getPreferenceData(AppConstants.cityId).isNotEmpty && authProvider.getPreferenceData(AppConstants.name).isNotEmpty){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
          }else{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NameCityScreen(phone: widget.mobileNumber)));
          }
        }else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Wrong OTP'),
            backgroundColor: Colors.red,
          ));
        }

      });

    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid OTP'),
        backgroundColor: Colors.red,
      ));
    }
  }

  loginCallback(bool isRoute,String errorMessage){

  }
}
