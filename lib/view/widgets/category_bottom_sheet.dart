import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flyseas/data/model/response/main_category_response.dart';
import 'package:flyseas/util/color_resources.dart';
import 'package:flyseas/util/dimensions.dart';
import 'package:flyseas/util/images.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../provider/home_provider.dart';
import '../../util/app_constants.dart';
import '../../util/progress_dialog.dart';

class CategoryBottomSheet extends StatefulWidget {
  const CategoryBottomSheet({Key? key}) : super(key: key);

  @override
  State<CategoryBottomSheet> createState() => _CategoryBottomSheetState();
}

class _CategoryBottomSheetState extends State<CategoryBottomSheet> {
  //List<RadioModel> sampleData =  [];

  @override
  void initState() {
    super.initState();
    //sampleData.add(RadioModel(false, 'Bakery', "Cakes, Pastries, Patties, Sandwiches Donuts & many more.",Images.catFoodIcon));
    //sampleData.add(RadioModel(false, 'FMCG', "Food - Staples, FMCG, Fruits & Vegetables, Meat",Images.catFoodIcon));
    //sampleData.add(RadioModel(false, 'Clothing', "Women's Garments, Men's Garments,Women's Ethnic, Women's Western, Kid's Garments",Images.catClothIcon));
    //sampleData.add(RadioModel(false, 'Electronics', "Mobiles Accessories, IT & Accessories,COVID Essentials, Appliances, Smartphones",Images.catElectronicIcon));
  }

  final TextStyle defaultStyle = const TextStyle(color: Colors.white, fontSize: 26.0,fontWeight: FontWeight.w700);
  final TextStyle linkStyle = const TextStyle(color: ColorResources.gradientOne,fontSize: 26,fontWeight: FontWeight.w700);


  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height * .6,
      decoration: const BoxDecoration(
        color: Color(0xFF3B0B45),
        borderRadius: BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16))
      ),
      child: ListView(
        children: [
          const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(text: TextSpan(
                    style: defaultStyle,
                    children: [
                      const TextSpan(text: 'Select a '),
                      TextSpan(
                          text: 'category',
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {

                            }),
                    ]
                )),
                const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL,),
                // category icon , canteen outlet
                Row(children: [
                  Text('Your School : ${Provider.of<AuthProvider>(context).getPreferenceData(AppConstants.city)}',style: TextStyle(fontSize: 12,color: Colors.white),),
                ],),
                Container(
                  margin: const EdgeInsets.only(left: 100,right: 100,top: 30,bottom: 5),
                  color: Colors.white,
                  height: 1,
                )
              ],
            ),
          ),
          Consumer<HomeProvider>(builder: (context,homeProvider,child){
            return ListView.builder(
              itemCount: homeProvider.mainCategoryList.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  //highlightColor: Colors.red,
                  splashColor: Colors.blueAccent,
                  onTap: () {
                    setState(() {
                      homeProvider.updateCategory(index);
                      Navigator.pop(context);

                    });
                  },
                  child: RadioItem(homeProvider.mainCategoryList[index]),
                );
              },
            );
          }),
          GestureDetector(
            onTap: (){


            },
            child: Container(
              height: 54,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top:35,left: 34, right: 34,bottom: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(child: Text('DONE',style: TextStyle(color: ColorResources.gradientOne,fontSize: 14,fontWeight: FontWeight.w700),)),
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateCategory() async {
    String phone = Provider.of<AuthProvider>(context, listen: false).getPreferenceData(AppConstants.phone);
    int categoryId = Provider.of<HomeProvider>(context, listen: false).selectedCategory;
    if(categoryId==0){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please Select Category'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    Map<String, String> loginData = {};
    loginData['category_id'] = categoryId.toString();
    loginData['phone'] = phone;

    ProgressDialog.showLoadingDialog(context);
    await Provider.of<AuthProvider>(context, listen: false)
        .loginWithPhone(loginData, loginCallback,isOtpVerified: true);
  }

  loginCallback(bool isRoute, String token, String errorMessage) {
    if (isRoute) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.green,
      ));
      //phoneNumberController.clear();
      ProgressDialog.closeLoadingDialog(context);
    } else {
      ProgressDialog.closeLoadingDialog(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
    }
  }

}

class RadioItem extends StatelessWidget {
  final MainCategory _item;
  const RadioItem(this._item, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin:  EdgeInsets.only(left: 34,right: 34,top: 15),
      child:  Container(
       height: 74.0,
       width: MediaQuery.of(context).size.width * .7,
       child:  Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Expanded(
             flex: 4,
             child: Row(
               //mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 Expanded(
                   flex: 3,
                   child: Container(
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                     ),
                     alignment: Alignment.centerLeft,
                     padding: EdgeInsets.only(top: 5,bottom: 5,left: 5),
                     child: Image.network(_item.icon,height: 60,width: 60,),
                   ),
                 ),
                 Expanded(
                   flex: 7,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(_item.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
                       Text(_item.description,style: TextStyle(fontSize: 9,fontWeight: FontWeight.w500,color: Colors.white),),
                     ],
                   ),
                 )
               ],
             ),
           ),
           Expanded(
             //flex: 1,
             child: Container(
               //width: 34,
               //height: 34,
               margin: EdgeInsets.all(17),
               decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 color: _item.isSelected ? Colors.white : ColorResources.gradientOne,
               ),
               child: Center(child: Icon(Icons.check,color: _item.isSelected ? Color(0xFFE7138E) : Color(0xFF970F6C),)),
             ),
           ),
         ],
       ),
       decoration:  BoxDecoration(
         /*color: _item.isSelected
             ? Colors.blueAccent
             : Colors.transparent,*/
         gradient:  const LinearGradient(
             begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
             colors: [
               ColorResources.gradientOne,
               ColorResources.gradientTwo,
             ]
         ),
         border:  Border.all(
             width: 1.0,
             color: _item.isSelected
                 ? ColorResources.WHITE
                 : ColorResources.gradientOne),
         borderRadius: const BorderRadius.all(const Radius.circular(40.0)),
       ),
          ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String headerText;
  final String contentText;
  final String icon;

  RadioModel(this.isSelected, this.headerText, this.contentText,this.icon);
}
