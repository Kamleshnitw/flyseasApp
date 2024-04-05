import 'package:flutter/material.dart';
import 'package:flyseas/provider/home_provider.dart';
import 'package:flyseas/provider/profile_provider.dart';
import 'package:flyseas/view/screens/auth_screen/auth_screen.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';
import '../../../util/color_resources.dart';
import '../../global_widget/logout_dialog.dart';


class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Detail'),backgroundColor: ColorResources.gradientOne,),
      backgroundColor: Color(0xFFFFE8F5),
      body: Consumer<ProfileProvider>(builder: (context,profileProvider,child){
        return ListView(
          padding: EdgeInsets.symmetric(vertical: 16),
          children: [
            const SizedBox(height: 16,),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage("https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png"),
                backgroundColor: Colors.blue[100],
              ),
            ),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
              child: Text('Name'),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Icon(Icons.person_outline),
                  const SizedBox(width: 8,),
                  Text(profileProvider.profileDetailResponse!.profile.name)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
              child: Text('Phone'),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Icon(Icons.phone),
                  const SizedBox(width: 8,),
                  Text(profileProvider.profileDetailResponse!.profile.phone)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
              child: Text('Email Account'),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Icon(Icons.email_outlined),
                  const SizedBox(width: 8,),
                  Text('User@gmail.com')
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
              child: Text('Account Security'),
            ),
            GestureDetector(
              onTap: (){
                showGeneralDialog(context: context,
                    pageBuilder: (context, animation1, animation2) => const LogoutDialog());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    const SizedBox(width: 8,),
                    Text('Logout')
                  ],
                ),
              ),
            ),
            /*Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 30,vertical: 16),
              child: ElevatedButton(onPressed: (){

              }, style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ColorResources.gradientOne)
                  ),
                  child: const Text('Delete My Account')),
            )*/
          ],
        );
      },),

    );
  }

  void logout(){
    Provider.of<AuthProvider>(context, listen: false).clearSharedData().then((condition) {
      Navigator.pop(context);
      Provider.of<HomeProvider>(context, listen: false).updateHomePageIndex(0);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AuthScreen()), (route) => false);
    });

  }

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are You Sure?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                logout();
              },
            ),
            TextButton(
              child: const Text('NO'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
