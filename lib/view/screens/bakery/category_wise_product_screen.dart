import 'package:flutter/material.dart';
import 'package:flyseas/provider/home_provider.dart';
import 'package:flyseas/provider/product_provider.dart';
import 'package:flyseas/util/color_resources.dart';
import 'package:flyseas/util/progress_dialog.dart';
import 'package:flyseas/view/screens/bakery/product_detail_screen.dart';
import 'package:flyseas/view/widgets/bottom_cart_widget.dart';
import 'package:flyseas/view/widgets/cart_widget.dart';
import 'package:flyseas/view/widgets/kyc_bottom_sheet.dart';
import 'package:flyseas/view/widgets/show_price_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/bakery_home_response.dart';
import '../../../util/dimensions.dart';
import '../kyc_screen/user_kyc_screen.dart';

class CategoryWiseProductScreen extends StatefulWidget {
  final Category category;
  const CategoryWiseProductScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryWiseProductScreen> createState() => _CategoryWiseProductScreenState();
}

class _CategoryWiseProductScreenState extends State<CategoryWiseProductScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getData();
    });

  }

  void getData() async {
    await Provider.of<ProductProvider>(context,listen: false).getProductByCategoryId(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeProvider>(context,listen: false);
    return Consumer<ProductProvider>(
        builder: (context,productProvider,child){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.appBarColor,
          elevation: 0.0,
          centerTitle: true,
          leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_outlined,color: ColorResources.gradientOne,)),
          title: Text('${widget.category.name} (${productProvider.productList.length})',style: TextStyle(color: ColorResources.gradientOne,),),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search,color: ColorResources.gradientOne,),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CartWidget(),
            ),
          ],
        ),
        body: Column(
          children: [
            //Image.network(widget.category.thumbnailImage,height: 150,fit: BoxFit.cover,),
            Expanded(
              //height: MediaQuery.of(context).size.height,
              child: Card(
                color: Color(0xFFFFF0F9),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),

                ),
                elevation: 16,
                margin: const EdgeInsets.only(top: 0),
                child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    physics: const ScrollPhysics(),
                    gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (1/homeProvider.kycStatus==2 ?  1.11 : .7)
                    ),
                    itemCount: productProvider.productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var productData = productProvider.productList[index];
                      return GestureDetector(
                        onTap: (){
                          if(homeProvider.kycStatus == 2){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(productId: productData.id,)));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),

                          ),
                          margin: EdgeInsets.all(2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.network(productData.variation[0].thumbnail,fit: BoxFit.cover,height: 150,width: double.maxFinite,)),
                                  Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Visibility(
                                        visible: (double.tryParse(productData.variation[0].discountPrice) ?? 0)>0,
                                        child: Container(
                                        decoration: BoxDecoration(
                                          color: ColorResources.gradientOne,
                                          borderRadius: BorderRadius.circular(4)
                                        ),
                                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                          child: Text('${productData.variation[0].discountType=='fixed' ? '₹' : ''} ${productData.variation[0].discountPrice} OFF',style: TextStyle(fontSize: 10,color: Colors.white),),
                                  ),
                                      ))
                                ],
                              ),
                              const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(productData.productName,textAlign: TextAlign.start,maxLines: 2,overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
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
                                          //Text(productData.variation[0].combinationName),
                                          Text('₹ ${productData.variation[0].mrpPrice}',style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.black54),),
                                          Text('₹ ${productData.variation[0].sellingPrice}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      productData.variation[0].inCart ?  Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: ColorResources.gradientOne),
                                                borderRadius: BorderRadius.circular(4)
                                            ),
                                            child: IconButton(
                                                constraints: const BoxConstraints(),
                                                padding: const EdgeInsets.all(2),
                                                onPressed: () async {
                                                  if (productData.variation[0].cartQuantity == 1) {
                                                    //remove
                                                    ProgressDialog.showLoadingDialog(context);
                                                    await productProvider.deleteToCart(
                                                      productData.id, productData.variation[0].combinationName)
                                                        .then((value) {
                                                      if (value) {
                                                        getData();
                                                        /*productProvider
                                                            .deleteItemFromCart(index);*/
                                                      } else {
                                                        //error
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                            const SnackBar(
                                                              content: Text("Error"),
                                                              backgroundColor:
                                                              Colors.red,
                                                            ));
                                                      }
                                                      ProgressDialog
                                                          .closeLoadingDialog(
                                                          context);
                                                    });
                                                  } else {
                                                    //update
                                                    ProgressDialog
                                                        .showLoadingDialog(
                                                        context);
                                                    await productProvider.updateToCart(
                                                        productData.id, productData.variation[0].cartQuantity-1,
                                                        productData.variation[0].combinationName)
                                                        .then((value) {
                                                      if (value) {
                                                        getData();
                                                       /* productProvider
                                                            .updateCartProduct(
                                                            index,
                                                            value["qty"]);*/
                                                      } else {
                                                        //error
                                                        ScaffoldMessenger.of(
                                                            context)
                                                            .showSnackBar(
                                                            const SnackBar(
                                                              content: Text("Error"),
                                                              backgroundColor:
                                                              Colors.red,
                                                            ));
                                                      }
                                                      ProgressDialog
                                                          .closeLoadingDialog(
                                                          context);
                                                    });
                                                  }
                                                },
                                                icon: const Icon(Icons.remove,size: 18,color: ColorResources.gradientOne,)),

                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                                productData.variation[0].cartQuantity.toString(),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.0)),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: ColorResources.gradientOne,
                                                borderRadius: BorderRadius.circular(4)
                                            ),
                                            child: IconButton(
                                              constraints: const BoxConstraints(),
                                              padding: const EdgeInsets.all(2),
                                              onPressed: () async {
                                                //update
                                                ProgressDialog.showLoadingDialog(context);
                                                await productProvider.updateToCart(
                                                    productData.id, productData.variation[0].cartQuantity+1,
                                                    productData.variation[0].combinationName)
                                                    .then((value) {
                                                  if (value) {
                                                    getData();
                                                   /* productProvider.updateCartProduct(index, value["qty"]);} else {
                                                    //error
                                                    ScaffoldMessenger.of(
                                                        context)
                                                        .showSnackBar(
                                                        const SnackBar(
                                                          content: Text("Error"),
                                                          backgroundColor:
                                                          Colors.red,
                                                        ));*/
                                                  }
                                                  ProgressDialog
                                                      .closeLoadingDialog(
                                                      context);
                                                });
                                              },
                                              icon: const Icon(Icons.add,size: 18,color: Colors.white,),
                                            ),
                                          ),
                                        ],
                                      ):  GestureDetector(
                                        onTap: () async{
                                          if(productData.variation[0].inCart){
                                            // remove from cart
                                            ProgressDialog.showLoadingDialog(context);
                                            await productProvider.deleteToCart(productData.id,productData.variation[0].combinationName).then((value) {
                                              ProgressDialog.closeLoadingDialog(context);
                                              if(value){
                                                productData.variation[0].inCart = false;
                                                productProvider.updateData();
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  content: Text("Product remove from cart."),
                                                  backgroundColor: Colors.green,
                                                ));
                                              }
                                            });
                                          }
                                          else{
                                            // add in cart
                                            ProgressDialog.showLoadingDialog(context);
                                            await productProvider.addToCart(productData.id, 1,productData.variation[0].combinationName).then((value){
                                              ProgressDialog.closeLoadingDialog(context);
                                              if(value){
                                                productData.variation[0].inCart = true;
                                                productProvider.updateData();
                                                getData();
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  content: Text("Product added in cart successfully."),
                                                  backgroundColor: Colors.green,
                                                ));
                                              }
                                            });
                                          }


                                        },
                                        child:
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
                                  ),
                                  ]
                                ),
                              ),
                            ],

                          ),
                        ),
                      );
                    }
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomCartWidget(),
      );
    });
  }

}
