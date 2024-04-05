import 'package:flutter/material.dart';
import 'package:flyseas/util/app_constants.dart';
import 'package:flyseas/view/screens/home/dashboard_screen.dart';
import 'package:flyseas/view/screens/name_city_screen/name_city_screen.dart';
import 'package:flyseas/view/screens/term_continue_screen/term_continue_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: (5)),
      vsync: this,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.asset(
        'assets/logo_an.json',
        controller: _controller,
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.height * 1,
        animate: true,
        fit: BoxFit.cover,
        onLoaded: (composition) {
          _controller
            ..duration = composition.duration
            ..forward().whenComplete((){

              if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                print(Provider.of<AuthProvider>(context, listen: false).getPreferenceData(AppConstants.city));
                if(Provider.of<AuthProvider>(context, listen: false).getPreferenceData(AppConstants.city).isNotEmpty){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashboardScreen()));
                }
                else{
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => NameCityScreen(phone: Provider.of<AuthProvider>(context, listen: false).getPreferenceData(AppConstants.phone))));
                }

              } else {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TermContinueScreen()));

              }

            });
        },
      ),
    );
  }
}
