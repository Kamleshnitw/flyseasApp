
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flyseas/util/color_resources.dart';
import 'package:flyseas/util/dimensions.dart';
import 'package:flyseas/view/screens/home/dashboard_screen.dart';

import '../../../util/images.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {

  final TextStyle defaultStyle = const TextStyle(color: Colors.white, fontSize: 26.0);
  final TextStyle linkStyle = const TextStyle(color: ColorResources.gradientOne,fontSize: 26);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backgroundImage,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,),
          Padding(
            padding: const EdgeInsets.all(Dimensions.MARGIN_SIZE_EXTRA_LARGE),
            child: ListView(
              children: [
                //const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,),
                Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topLeft,
                    child: const Icon(Icons.arrow_back_ios_outlined,color: Colors.white,)),

                CircleAvatar(
                  backgroundImage: AssetImage(Images.shopKeeperImage),
                  backgroundColor: Color(0xFFF5F5F5),
                  radius: 60,

                ),
                const SizedBox(height: 30,),
                RichText(text: TextSpan(
                    style: defaultStyle,
                    children: [
                      const TextSpan(text: 'Enter Your '),
                      TextSpan(
                          text: 'Name',
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {

                            }),
                    ]
                )),
                const SizedBox(height: 8,),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Full Name',
                      prefixStyle: TextStyle(color: Colors.black)
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 30,),
                RichText(text: TextSpan(
                    style: defaultStyle,
                    children: [
                      const TextSpan(text: "Enter Shop's "),
                      TextSpan(
                          text: 'Name',
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {

                            }),
                    ]
                )),
                const Text('Your shop or business name will be used to create invoice',style: TextStyle(color: ColorResources.WHITE),),
                const SizedBox(height: 8,),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter Shop or Business Name',
                      prefixStyle: TextStyle(color: Colors.black)
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 30,),
                RichText(text: TextSpan(
                    style: defaultStyle,
                    children: [
                      const TextSpan(text: "Enter Shop's "),
                      TextSpan(
                          text: 'PinCode',
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {

                            }),
                    ]
                )),
                const SizedBox(height: 8,),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter 6 digit Pin Code',
                      prefixStyle: TextStyle(color: Colors.black)
                  ),
                  autofocus: true,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DashboardScreen()));
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * .9,
                    margin: EdgeInsets.only(top: 60),
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
                    child: const Center(child: Text('Continue',style: TextStyle(color: ColorResources.WHITE,fontSize: 18,fontFamily: 'Roboto'),)),
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
