import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flyseas/provider/balance_provider.dart';
import 'package:flyseas/provider/profile_provider.dart';
import 'package:flyseas/util/app_constants.dart';
import 'package:flyseas/util/color_resources.dart';
import 'package:flyseas/view/global_widget/logout_dialog.dart';
import 'package:flyseas/view/screens/address/my_address_screen.dart';
import 'package:flyseas/view/screens/auth_screen/auth_screen.dart';
import 'package:flyseas/view/screens/balance_sheet/balance_sheet_screen.dart';
import 'package:flyseas/view/screens/bank_details/bank_details_screen.dart';
import 'package:flyseas/view/screens/kyc_screen/user_kyc_screen.dart';
import 'package:flyseas/view/screens/order/order_list_screen.dart';
import 'package:flyseas/view/screens/profile_detail/profile_detail.dart';
import 'package:flyseas/view/screens/wallet/wallet_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../provider/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getData();
    });
  }

  getData() async {
    await Provider.of<ProfileProvider>(context,listen: false).getProfileDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        elevation: 0,
      ),
      body: Consumer<ProfileProvider>(builder: (context,profileProvider,child){
        return profileProvider.isProfileLoading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))) :
        profileProvider.profileDetailResponse==null ?
        GestureDetector(
            onTap: (){
              logout();
            },
            child: const Center(child: Text('Profile Data Error Login Again'),)) :ListView(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileDetailScreen()));
              },
              child: Container(
                color: const Color(0xFFFFE8F5),
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.network(
                          "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                          height: 60,
                          width: 60,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(profileProvider.profileDetailResponse!.profile.name),
                            Text('+91-${profileProvider.profileDetailResponse!.profile.phone}'),
                          ],
                        )
                      ],
                    ),
                    const Icon(Icons.navigate_next)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8,),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OrderListScreen()));
              },
              child: profileOption("assets/images/my_address_icon.svg", "My Orders",iconData: Icons.shopping_bag_outlined),
            ),
            Consumer<BalanceProvider>(builder: (context,balanceProvider,child){
              return ListTile(
                leading: const Icon(Icons.account_balance_wallet_outlined,size: 18,color: ColorResources.gradientOne),
                title: const Text("${AppConstants.appName} Wallet",style: TextStyle(color: ColorResources.gradientOne)),
                trailing: Text('₹ ${balanceProvider.balance}'),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WalletScreen()));
                },
              );
            }),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  MyAddressScreen()));
              },
              child:
              profileOption("assets/images/my_address_icon.svg", "My Address",iconData: Icons.location_on_outlined),
            ),
            /*GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  BalanceSheetScreen()));
              },
              child:
              profileOption("assets/images/my_address_icon.svg", "My Balance Sheet",iconData: Icons.menu_book_outlined),
            ),*/
            /*GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserKYCScreen(kycDetails: profileProvider.profileDetailResponse!.profile.kycDetails)));
              },
              child: profileOption(
                  "assets/images/my_address_icon.svg", "KYC Documents",iconData: Icons.text_snippet_outlined),
            ),*/
           /* GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  BankDetailsScreen(bankDetail: profileProvider.profileDetailResponse!.profile.bankDetail,)));
              },
              child:
              profileOption("assets/images/my_address_icon.svg", "Bank Detail",iconData: Icons.account_balance_outlined),
            ),*/
            GestureDetector(
              onTap: () {
                _launchUrl('https://flyseas.in/privacy.html');
              },
              child: profileOption("assets/images/my_address_icon.svg", "Privacy Policy",iconData: Icons.policy_outlined),
            ),
            GestureDetector(
              onTap: () {
                _launchUrl('https://flyseas.in/return.html');
              },
              child:
              profileOption("assets/images/my_address_icon.svg", "Return Policy",iconData: Icons.keyboard_return),
            ),
            GestureDetector(
              onTap: () {
                _launchUrl('https://flyseas.in/');
              },
              child: profileOption("assets/images/my_address_icon.svg", "Help & Support",iconData: Icons.support_agent),
            ),
            /*GestureDetector(
              onTap: () {
                _launchUrl('https://flyseas.in/termsofuse.html');
              },
              child:
              profileOption("assets/images/my_address_icon.svg", "Term of Use"),
            ),*/

            GestureDetector(
              onTap: () {
                _launchUrl('https://flyseas.in/');
              },
              child: profileOption(
                  "assets/images/my_address_icon.svg", "About Us",iconData: Icons.account_box_outlined),
            ),
            // GestureDetector(
            //   onTap: () {
            //
            //   },
            //   child: profileOption(
            //       "assets/images/my_address_icon.svg", "Logout"),
            // ),
            const SizedBox(height: 16,),
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)
                  ),
                  onPressed: (){
                    showGeneralDialog(context: context,
                        pageBuilder: (context, animation1, animation2) => const LogoutDialog());
              }, child: Text('Logout',style: TextStyle(fontSize: 12,color: ColorResources.gradientOne),)),
            )

          ],
        );
      }),
    );
  }

  void logout(){
    //logout
    Provider.of<AuthProvider>(context, listen: false)
        .clearSharedData()
        .then((condition) {
      Navigator.pop(context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AuthScreen()),
              (route) => false);
    });
  }

  Widget profileOption(String image, String name,{IconData iconData= Icons.person_outline}) {
    return ListTile(
      leading: Icon(iconData,size: 18,color: ColorResources.gradientOne),
      title: Text(name,style: TextStyle(color: ColorResources.gradientOne)),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
      child: Row(
        children: [
          //Image.asset(image),
          //SvgPicture.asset(image,width: 18,height: 18),
          Icon(iconData,size: 18,color: ColorResources.gradientOne,),
          const SizedBox(width: 8,),
          Text(name,style: TextStyle(color: ColorResources.gradientOne),)
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }
}
