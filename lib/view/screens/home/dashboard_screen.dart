import 'package:flutter/material.dart';
import 'package:flyseas/provider/home_provider.dart';
import 'package:flyseas/util/color_resources.dart';
import 'package:flyseas/util/images.dart';
import 'package:flyseas/view/screens/home/widget/cart_screen.dart';
import 'package:flyseas/view/screens/home/widget/home_screen.dart';
import 'package:flyseas/view/screens/home/widget/notification_screen.dart';
import 'package:flyseas/view/screens/home/widget/profile_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../provider/balance_provider.dart';
import '../../widgets/category_bottom_sheet.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double iconSize = 20;
  //int _selectedIndex = 0;
  static const TextStyle iconTextStyle =
      TextStyle(fontWeight: FontWeight.w600, fontSize: 11, color: Colors.white);
  //static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  //int selectedCategory = -1;

  final List<Widget> _widgetOptions = const [
    HomeScreen(),
    CartScreen(),
    NotificationScreen(),
    //ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).getMainCategoryList();
       Provider.of<BalanceProvider>(context,listen: false).getBalanceHistory();
      //Provider.of<HomeProvider>(context, listen: false).getHomeData();
      //selectedCategory = Provider.of<HomeProvider>(context, listen: false).selectedCategory;
     // print(Provider.of<HomeProvider>(context, listen: false).selectedCategory);
      if (Provider.of<HomeProvider>(context, listen: false).selectedCategory == 0) {
        _showCategoryBottomSheet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: ColorResources.appBarColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        /*leading: GestureDetector(
          onTap: (){
            if(_scaffoldKey.currentState?.isDrawerOpen==true){
              _scaffoldKey.currentState?.openEndDrawer();
            }else{
              _scaffoldKey.currentState?.openDrawer();
            }
          },
          child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFFFE8F5),
              ),
              child: const Icon(
                Icons.menu,
                color: ColorResources.gradientTwo,
              )),
        ),*/
        title: Column(
          children: [
            InkWell(
              onTap: (){
                _showCategoryBottomSheet();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(Provider.of<HomeProvider>(context, listen: true).categoryName,style: const TextStyle(color: Colors.black,fontSize: 14),),
                      const Icon(Icons.arrow_drop_down,color: Colors.black,)
                    ],
                  ),
                  const Text('Change',style: TextStyle(color: ColorResources.gradientOne,fontSize: 12),)
                ],
              ),
            )
          ],
        ),
        actions: [
          GestureDetector(
            onTap: (){
              //Provider.of<HomeProvider>(context,listen: false).updateHomePageIndex(3);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfileScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: CircleAvatar(
                backgroundImage: const AssetImage(Images.shopKeeperImage),
                backgroundColor: ColorResources.colorMap[50],
                radius: 20,
              ),
            ),
          )
        ],
      ),
      /*drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              const SizedBox(height: 16,),
              Image.asset(Images.splashLogo,height: 150,width: 150,),
              const SizedBox(height: 16,),
              ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home_outlined),
                trailing: Icon(Icons.navigate_next),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Privacy Policy'),
                leading: Icon(Icons.privacy_tip_outlined),
                trailing: Icon(Icons.navigate_next),
                onTap: (){
                  Navigator.pop(context);
                  launchUrl(Uri.parse("https://flyseas.in/"));
                },
              ),
              ListTile(
                title: Text('About Flyseas'),
                leading: Icon(Icons.business_outlined),
                trailing: Icon(Icons.navigate_next),
                onTap: (){
                  Navigator.pop(context);
                  launchUrl(Uri.parse("https://flyseas.in/"));
                },
              ),
              ListTile(
                title: Text('Contact Us'),
                leading: Icon(Icons.contact_mail_outlined),
                trailing: Icon(Icons.navigate_next),
                onTap: (){
                  Navigator.pop(context);
                  launchUrl(Uri.parse("https://flyseas.in/"));
                },
              ),
              ListTile(
                title: Text('Support'),
                leading: Icon(Icons.support_agent),
                trailing: Icon(Icons.navigate_next),
                onTap: (){
                  Navigator.pop(context);
                  launchUrl(Uri.parse("https://flyseas.in/"));
                },
              )
            ],
          ),
        ),
      ),*/
      body: Center(
        child: _widgetOptions.isNotEmpty
            ? _widgetOptions.elementAt(Provider.of<HomeProvider>(context,listen: true).selectedHomePageIndex)
            : const SizedBox(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorResources.gradientOne,
                ColorResources.gradientTwo,
              ]),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
            child: Consumer<HomeProvider>(
              builder: (context,homeProvider,child){
                return GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: ColorResources.WHITE,
                  iconSize: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.white24,
                  color: ColorResources.WHITE,
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                      textStyle: iconTextStyle,
                      padding: EdgeInsets.zero,
                      leading: Container(
                        child: homeProvider.selectedHomePageIndex == 0
                            ? Image.asset(
                          Images.homeColorIcon,
                          height: iconSize,
                          width: iconSize,
                        )
                            : Image.asset(Images.homeIcon,
                            height: iconSize, width: iconSize),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: homeProvider.selectedHomePageIndex == 0
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    GButton(
                      icon: Icons.favorite_border,
                      text: 'Cart',
                      textStyle: iconTextStyle,
                      padding: EdgeInsets.zero,
                      leading: Container(
                        child: homeProvider.selectedHomePageIndex == 1
                            ? Image.asset(Images.cartColorIcon,
                            height: iconSize, width: iconSize)
                            : Image.asset(Images.cartIcon,
                            height: iconSize, width: iconSize),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: homeProvider.selectedHomePageIndex == 1
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    GButton(
                      icon: Icons.search,
                      text: 'Notification',
                      textStyle: iconTextStyle,
                      padding: EdgeInsets.zero,
                      leading: Container(
                        child: homeProvider.selectedHomePageIndex == 2
                            ? Image.asset(Images.notificationColorIcon,
                            height: iconSize, width: iconSize)
                            : Image.asset(Images.notificationIcon,
                            height: iconSize, width: iconSize),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: homeProvider.selectedHomePageIndex == 2
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    /*GButton(
                      icon: Icons.person_outline,
                      text: 'Profile',
                      textStyle: iconTextStyle,
                      padding: EdgeInsets.zero,
                      leading: Container(
                        child: homeProvider.selectedHomePageIndex == 3
                            ? Image.asset(Images.profileColorIcon,
                            height: iconSize, width: iconSize)
                            : Image.asset(Images.profileIcon,
                            height: iconSize, width: iconSize),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: homeProvider.selectedHomePageIndex == 3
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),*/
                  ],
                  selectedIndex: homeProvider.selectedHomePageIndex,
                  onTabChange: (index) {
                    homeProvider.updateHomePageIndex(index);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showCategoryBottomSheet(){
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return const CategoryBottomSheet();
      },
      isDismissible: false,
      barrierColor: Colors.white.withOpacity(0),
      backgroundColor: Colors.transparent,
    );
  }
}
