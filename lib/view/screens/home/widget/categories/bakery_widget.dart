import 'package:flutter/material.dart';
import 'package:flyseas/provider/home_provider.dart';
import 'package:flyseas/provider/product_provider.dart';
import 'package:flyseas/util/app_constants.dart';
import 'package:flyseas/util/progress_dialog.dart';
import 'package:flyseas/view/screens/bakery/category_list_screen.dart';
import 'package:flyseas/view/screens/bakery/product_list_screen.dart';
import 'package:flyseas/view/screens/kyc_screen/user_kyc_screen.dart';
import 'package:flyseas/view/widgets/kyc_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/auth_provider.dart';
import '../../../../../util/color_resources.dart';
import '../../../../../util/custom_themes.dart';
import '../../../../../util/dimensions.dart';
import '../../../../../util/images.dart';
import '../../../bakery/category_wise_product_screen.dart';
import '../../../bakery/product_detail_screen.dart';
import '../../../kyc_screen/kyc_screen.dart';

class BakeryWidget extends StatefulWidget {
  const BakeryWidget({Key? key}) : super(key: key);

  @override
  State<BakeryWidget> createState() => _BakeryWidgetState();
}

class _BakeryWidgetState extends State<BakeryWidget> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).getHomeData();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context,homeProvider,child){
      return homeProvider.isError? const Text('No Vendor Available') :ListView(
        children: [
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Text('Namaste',style: TextStyle(fontSize: Dimensions.FONT_SIZE_OVER_LARGE,fontWeight: FontWeight.w700),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Text(Provider.of<AuthProvider>(context,listen: false).getPreferenceData(AppConstants.name),style: TextStyle(fontSize: Dimensions.FONT_SIZE_OVER_LARGE,fontWeight: FontWeight.w400,color: ColorResources.gradientOne)),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
                border: Border.all(color: ColorResources.gradientOne),
                borderRadius: BorderRadius.all(Radius.circular(40))
            ),
            child: const TextField(
              decoration:  InputDecoration(
                  //suffixIcon: Icon(Icons.mic,color: ColorResources.gradientOne,),
                  prefixIcon: Icon(Icons.search,color: ColorResources.gradientOne),
                  contentPadding: EdgeInsets.all(8.0),
                  hintText: 'Search...',
                  border: InputBorder.none
              ),
            ),
          ),
          homeProvider.kycStatus == 0 ? Visibility(
            visible: false,
            child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: Color(0xFFFFE8F5)
                ),
                margin: EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_DEFAULT,vertical: 12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 12),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Complete Shop KYC to :',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: ColorResources.gradientOne),),
                          const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL,),
                          const Text('Check best margin on products.',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400)),
                          const Text('Place successful orders.',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400)),
                          const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const UserKYCScreen()));
                            },
                            child: Container(
                              height: 34,
                              width: MediaQuery.of(context).size.width * .68,
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
                              child: const Center(child: Text('Upload Certificate',style: TextStyle(color: ColorResources.WHITE,fontSize: 14,fontWeight: FontWeight.w700),)),
                            ),
                          )

                        ],
                      ),
                      Positioned(
                          right: 0,
                          child: Image.asset(Images.kycIcon,height: 125,width: 125,)),
                    ],
                  ),
                )),
          ) : SizedBox(),
          Container(
            height: homeProvider.topSlider.isEmpty ? 0: 160,
            margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homeProvider.topSlider.length,
                itemBuilder: (context,index){
                  return Container(
                    width: 280,
                    margin: EdgeInsets.only(right: Dimensions.MARGIN_SIZE_DEFAULT),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16))
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(homeProvider.topSlider[index],fit: BoxFit.cover,)),
                  );
                }),
          ),
          const SizedBox(height: 16,),
          homeProvider.newArrival.isNotEmpty ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_DEFAULT,vertical: Dimensions.MARGIN_SIZE_SMALL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('New Arrivals',style: titleHeaderHome,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductListScreen()));
                  },
                  child: Row(
                    children: const [
                      Text('View All',style: TextStyle(fontSize: 11,color: ColorResources.gradientOne,fontWeight: FontWeight.w600),),
                      Icon(Icons.navigate_next,color: ColorResources.gradientOne,size: 16,)
                    ],
                  ),
                )
              ],
            ),
          ) : const SizedBox(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: homeProvider.newArrival.isNotEmpty ?  200 : 0,
            child: ListView.builder(
                itemCount: homeProvider.newArrival.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      if(homeProvider.kycStatus == 2){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(productId: homeProvider.newArrival[index].id)));
                      }
                    },
                    child: Container(
                      width: 140,
                      margin: const EdgeInsets.only(right: 4),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(homeProvider.newArrival[index].variation[0].thumbnail,fit: BoxFit.cover,)),
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(height: 16,),
          homeProvider.homeCategory.isNotEmpty ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_DEFAULT,vertical: Dimensions.MARGIN_SIZE_SMALL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Browse By Categories',style: titleHeaderHome,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CategoryListScreen()));
                  },
                  child: Row(
                    children: const [
                      Text('View All',style: TextStyle(fontSize: 11,color: ColorResources.gradientOne,fontWeight: FontWeight.w600),),
                      Icon(Icons.navigate_next,color: ColorResources.gradientOne,size: 16,)
                    ],
                  ),
                )
              ],
            ),
          ) : const SizedBox(),
          homeProvider.homeCategory.isNotEmpty ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: (1/1.2)
                ),
                itemCount: homeProvider.homeCategory.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CategoryWiseProductScreen(
                            category: homeProvider.homeCategory[index])));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(width: .5,color: Color(0xFFAAAAAA))
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),topRight: Radius.circular(4)),
                              child: Image.network(homeProvider.homeCategory[index].thumbnailImage,
                                fit: BoxFit.cover,height: 105,width: MediaQuery.of(context).size.width/1.5,)),
                          const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(homeProvider.homeCategory[index].name,maxLines:1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize:12,fontWeight: FontWeight.w600),),
                          ),
                          //const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL,),
                        ],

                      ),
                    ),
                  );
                }
            ),
          ) : SizedBox(),
          const SizedBox(height: 30,),
          homeProvider.midBanner.isNotEmpty ? Container(
            margin: const EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(homeProvider.midBanner,
                height: 180,width: MediaQuery.of(context).size.width * .9,fit: BoxFit.cover,),
            ),
          ) : SizedBox(),
          homeProvider.midBanner.isNotEmpty ? const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT,) : SizedBox(),
          ListView.builder(
              itemCount: homeProvider.groupProduct.length,
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context,index){
                var groupData = homeProvider.groupProduct[index];
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(groupData.groupName,style: titleHeaderHome,),
                            Row(
                              children: [
                                Text('View All',style: TextStyle(fontSize: 11,color: ColorResources.gradientOne,fontWeight: FontWeight.w600),),
                                Icon(Icons.navigate_next,color: ColorResources.gradientOne,size: 16,)
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: homeProvider.kycStatus==2 ?  165 : 190,
                        child: ListView.builder(
                            itemCount: groupData.products.length,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context,childIndex){
                              var productData = groupData.products[childIndex];
                              var productProvider = Provider.of<ProductProvider>(context,listen: false);
                              return GestureDetector(
                                onTap: (){
                                  if(homeProvider.kycStatus==2){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(productId: productData.id,)));
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 4,bottom: 1),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                      boxShadow: [
                                        BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 6.0,
                                      ),
                                    ]
                                  ),
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network(productData.variation[0].thumbnail,fit: BoxFit.cover,height: 85,width: 140,errorBuilder: (context,object,stack){
                                          return Container(
                                            height: 85,
                                            child: Center(
                                              child: Text('Image Not Available',style: TextStyle(fontSize: 10),),
                                            ),
                                          );
                                        },),
                                        const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(productData.productName,textAlign: TextAlign.start,maxLines: 2,overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600),),
                                            homeProvider.kycStatus != 2 ?  GestureDetector(
                                              onTap: (){
                                                showModalBottomSheet<void>(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return const KYCSheet();
                                                  },isDismissible: false,barrierColor: Colors.white.withOpacity(0),backgroundColor: Colors.transparent,);

                                              },
                                              child: Container(
                                                child: Text('View Prices',maxLines: 1,style: TextStyle(fontSize: 8),textAlign: TextAlign.center,),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: ColorResources.gradientOne),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                margin: EdgeInsets.only(top: 8),
                                                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 6),
                                              ),
                                            ) : Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(productData.categoryId.toString()),
                                                      Text('₹ ${productData.variation[0].mrpPrice}',style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.black54),),
                                                      Text('₹ ${productData.variation[0].sellingPrice}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async{
                                                      productData.isLoading = true;
                                                      homeProvider.updateProduct();
                                                      if(productData.variation[0].inCart){
                                                        // remove from cart
                                                        await productProvider.deleteToCart(productData.id,productData.variation[0].combinationName).then((value) {
                                                          if(value){
                                                            groupData.products[childIndex].variation[0].inCart = false;
                                                            homeProvider.updateProduct();
                                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                              content: Text("Product remove from cart."),
                                                              backgroundColor: Colors.green,
                                                            ));
                                                          }
                                                        });
                                                      }
                                                      else{
                                                        // add in cart
                                                        await productProvider.addToCart(productData.id, 1,productData.variation[0].combinationName).then((value){
                                                          if(value){
                                                            groupData.products[childIndex].variation[0].inCart = true;
                                                            homeProvider.updateProduct();
                                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                              content: Text("Product added in cart successfully."),
                                                              backgroundColor: Colors.green,
                                                            ));
                                                          }
                                                        });
                                                      }

                                                      productData.isLoading = false;
                                                      homeProvider.updateProduct();


                                                    },
                                                    child: productData.isLoading ?
                                                    CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)) :
                                                    Container(
                                                        decoration: const BoxDecoration(
                                                            color: Colors.white,
                                                            shape: BoxShape.rectangle,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.black12,
                                                                blurRadius: 5.0,
                                                              ),
                                                            ]
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Icon(
                                                            productData.variation[0].inCart ? Icons.remove : Icons.add,
                                                            color: ColorResources.gradientOne,
                                                          ),
                                                        )
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],

                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                );
              }),

          const SizedBox(height: 20,),
        ],
      );
    });
  }

}
