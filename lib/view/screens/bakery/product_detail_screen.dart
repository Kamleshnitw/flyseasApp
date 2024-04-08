
import 'package:flutter/material.dart';
import 'package:flyseas/data/model/response/bakery_home_response.dart';
import 'package:flyseas/provider/product_provider.dart';
import 'package:flyseas/util/custom_themes.dart';
import 'package:flyseas/util/dimensions.dart';
import 'package:flyseas/view/screens/bakery/product_list_screen.dart';
import 'package:flyseas/view/widgets/kyc_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../provider/home_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/progress_dialog.dart';
import '../../widgets/cart_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  const ProductDetailScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getData();
    });

  }

  getData() async {
    await Provider.of<ProductProvider>(context,listen: false).getProductDescription(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeProvider>(context,listen: false);
    return Consumer<ProductProvider>(builder: (context,productProvider,child){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.appBarColor,
          elevation: 0.0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_outlined,
              color: ColorResources.gradientOne,
            ),
          ),
          title: Text(
            productProvider.productDescriptionResponse?.productDescription.productName ?? "",
            style:const  TextStyle(color: ColorResources.gradientOne,),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            GestureDetector(
              onTap: (){

              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  color: ColorResources.gradientOne,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CartWidget(),
            ),
          ],
        ),
        body: productProvider.productDescriptionResponse !=null ? ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        productProvider.productDescriptionResponse?.productDescription.variation[0].thumbnail ?? "",
                        height: 210,
                        fit: BoxFit.cover,
                      )),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productProvider.productDescriptionResponse?.productDescription.productName ?? "",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              //const SizedBox(height: 4,),
                              //Text(productProvider.variationName.replaceAll("-", " "), style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                              const SizedBox(height: 8,),
                              Text("₹ ${productProvider.getSelectedVariation().mrpPrice}", style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,decoration: TextDecoration.lineThrough)),
                              const SizedBox(height: 8,),
                              Text("₹ ${productProvider.getSelectedVariation().sellingPrice}",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  /*Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFFFFD7EE),
                                          border: Border.all(color: ColorResources.gradientOne,width: 1),
                                          borderRadius: BorderRadius.circular(16)
                                      ),
                                      padding: EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 8,
                                            width: 8,
                                            margin: EdgeInsets.symmetric(horizontal: 4),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.green),
                                          ),
                                          Text('Eggless',style: TextStyle(fontSize: 10)),
                                        ],
                                      )),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFFFFD7EE),
                                          border: Border.all(color: ColorResources.gradientOne,width: 1),
                                          borderRadius: BorderRadius.circular(16)
                                      ),
                                      padding: EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 8,
                                            width: 8,
                                            margin: EdgeInsets.symmetric(horizontal: 4),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                          ),
                                          Text('Egg',style: TextStyle(fontSize: 10),),
                                        ],
                                      )),*/
                                ],
                              ),
                              const SizedBox(height: 8,),
                              /*Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFF0F9),
                                    border: Border.all(color: ColorResources.gradientOne,width: 1),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 4,),
                                    Text('Choose Shape',style: TextStyle(fontSize: 8)),
                                    const SizedBox(height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.circle_outlined,color: ColorResources.gradientOne),
                                        Icon(Icons.favorite_border,color: ColorResources.gradientOne),
                                        Icon(Icons.square_outlined,color: ColorResources.gradientOne),
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                  ],
                                ),
                              ),*/
                              const SizedBox(height: 8,),
                              productProvider.addingCart ?
                              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)) :
                              productProvider.getSelectedVariation().inCart==true ?  GestureDetector(
                                onTap: (){
                                  TextEditingController quantityController = TextEditingController();
                                  quantityController.text = productProvider.getSelectedVariation().quantity.toString();
                                  showModalBottomSheet<void>(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding: MediaQuery.of(context).viewInsets,
                                        child: Container(
                                          height: 200,
                                          color: Colors.white,
                                          padding: EdgeInsets.all(16),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const Text('Update Quantity'),
                                                const SizedBox(height: 20,),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        flex:4,
                                                        child: TextField(
                                                          controller: quantityController,
                                                          keyboardType: TextInputType.number,
                                                          decoration: InputDecoration(
                                                            border: OutlineInputBorder(),
                                                            labelText: 'Quantity',
                                                          ),
                                                        )),
                                                    const SizedBox(width: 16,),
                                                    Expanded(
                                                        flex: 2,
                                                        child: GestureDetector(
                                                          onTap: (){
                                                            productProvider.deleteToCart(productProvider.productDescriptionResponse!.productDescription.id,
                                                                productProvider.variationName).then((value){
                                                              if(value){
                                                                productProvider.getSelectedVariation().inCart = false;
                                                                productProvider.getSelectedVariation().quantity = "0";
                                                                productProvider.updateData();
                                                                Navigator.pop(context);
                                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                  content: Text("Product Remove From Cart Successfully."),
                                                                  backgroundColor: Colors.green,
                                                                ));
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: ColorResources.getRed(context),width: 1)
                                                            ),
                                                            padding: const EdgeInsets.symmetric(vertical: 8),
                                                            child: Center(child: Text('Remove',style: TextStyle(color: ColorResources.getRed(context)),)),

                                                    ),
                                                        ))
                                                  ],
                                                ),
                                                ElevatedButton(
                                                  child: const Text('Confirm'),
                                                  style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all(ColorResources.gradientOne)
                                                  ),
                                                  onPressed: () {
                                                    if(quantityController.text.isNotEmpty){
                                                      productProvider.updateToCart(productProvider.productDescriptionResponse!.productDescription.id, int.parse(quantityController.text),productProvider.variationName) .then((value){
                                                        if(value){
                                                          productProvider.updateData();
                                                          productProvider.getSelectedVariation().quantity = (quantityController.text);
                                                          Navigator.pop(context);
                                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                            content: Text("Product quantity update successfully."),
                                                            backgroundColor: Colors.green,
                                                          ));
                                                        }
                                                      });
                                                    }
                                                    else{
                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                        content: Text("Product Quantity Required"),
                                                        backgroundColor: Colors.green,
                                                      ));
                                                    }

                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },

                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: ColorResources.gradientOne,width: 1)
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Qty : ${productProvider.getSelectedVariation().quantity}'),
                                      Icon(Icons.keyboard_arrow_down_rounded),

                                    ],
                                  ),
                                ),
                              ) :
                              ElevatedButton(onPressed: (){
                                productProvider.addToCart(productProvider.productDescriptionResponse!.productDescription.id, 1,productProvider.variationName).then((value) {
                                  if(value){
                                    productProvider.getSelectedVariation().quantity = "1";
                                    productProvider.getSelectedVariation().inCart = true;
                                    productProvider.updateData();
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text("Product Added In Cart Successfully."),
                                      backgroundColor: Colors.green,
                                    ));
                                  }
                                });

                              }, child: Text('Add'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(ColorResources.gradientOne)),)
                            ],
                          ))
                    ],
                  ),
                  _buildAttributes(productProvider.productDescriptionResponse!.productDescription.attributes,productProvider),

                  Container(height: 1,color: Colors.black26,margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: 16,
                        margin: EdgeInsets.symmetric(horizontal: 4,vertical: 5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFFD7EE)),
                      ),
                      Expanded(child: Text(productProvider.getSelectedVariation().description))
                    ],
                  ),
                  const SizedBox(height: 6,),
                  Row(
                    children: [
                      Container(
                        height: 16,
                        width: 16,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFFD7EE)),
                      ),
                      Text('No Return allowed')
                    ],
                  ),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      showModalBottomSheet<void>(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                color: Colors.white
                              ),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        Text('Specification',style: titilliumBold,),
                                        const SizedBox(height: 16,),
                                        TextButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, child: Text('Close'))
                                    ],
                                  ),
                                  Text('${productProvider.getSelectedVariation().description}'),
                                ],
                              ));
                        },isDismissible: true,barrierColor: Colors.white.withOpacity(0),backgroundColor: Colors.transparent,);
                    },
                    child: Row(
                      children: [
                        Text('VIEW SPECIFICATION',style: TextStyle(fontSize: 16,color: ColorResources.gradientOne)),
                        Icon(Icons.navigate_next_rounded,color: ColorResources.gradientOne,)
                      ],
                    ),
                  ),
                  const SizedBox(height: 18,),
                ],
              ),
            ),
            Visibility(
              visible: productProvider.relatedProducts.isNotEmpty,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFFFFF0F9),
                          Color(0xFFFB9FD3),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                    )
                ),
                padding: EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('More Items',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProductListScreen()));
                            },
                            child: Row(
                              children: [
                                Text('View All',style: TextStyle(fontSize: 14,color: ColorResources.gradientOne,fontWeight: FontWeight.w500),),
                                Icon(Icons.navigate_next,color: ColorResources.gradientOne,size: 16,)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 185,
                      child: ListView.builder(
                          itemCount: productProvider.relatedProducts.length,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context,childIndex){
                            var productData = productProvider.relatedProducts[childIndex];
                            return GestureDetector(
                              onTap: (){
                                if(homeProvider.kycStatus == 2){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(productId: productData.id,)));
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                width: 125,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(productData.variation[0].thumbnail,fit: BoxFit.cover,height: 85,width: 140,),
                                      const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(productData.productName,textAlign: TextAlign.start,maxLines: 2,overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600),),
                                          GestureDetector(
                                            onTap: (){
                                              showModalBottomSheet<void>(
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return const KYCSheet();
                                                },isDismissible: false,barrierColor: Colors.white.withOpacity(0),backgroundColor: Colors.transparent,);

                                            },
                                            child: homeProvider.kycStatus != 2 ?  GestureDetector(
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
                                                      Text('₹ ${productData.variation[0].sellingPrice}',style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.black54),),
                                                      Text('₹ ${productData.variation[0].purchasePrice}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                                                    ],
                                                  ),
                                                  GestureDetector(
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
                                          )
                                        ],
                                      ),
                                    ],

                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            )
          ],
        ) : productProvider.isLoading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))) : const Text('Something Error'),
      );
    });
  }

  Widget _buildAttributes(List<Attribute> productAttributes,ProductProvider productProvider) {
    return  Column(
      children: [
        for(var attrIndex=0; attrIndex<productAttributes.length;attrIndex++)
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(productAttributes[attrIndex].variationName,style: titilliumBold,),
            const SizedBox(height: 5,),
            Row(
              children: [
                for (var valueIndex=0; valueIndex< productAttributes[attrIndex].variationValue.length;valueIndex++)
                  GestureDetector(
                    onTap: (){
                      //int index = productAttributes.indexWhere((element) => element.variationName==productAttributes[attrIndex].variationName);
                      //int childIndex = productAttributes[attrIndex].variationValue.indexOf(productAttributes[attrIndex].variationValue[valueIndex]);
                      productProvider.buildVariationName(attrIndex, valueIndex);
                      print("$attrIndex'th parent: $valueIndex child");
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(left: 8),
                      width: productAttributes[attrIndex].variationValue[valueIndex].length<5 ? 40: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1,color: productProvider.variantIndex[attrIndex]==valueIndex ? ColorResources.gradientOne : Colors.black38)
                      ),
                      child: Center(child: Text(productAttributes[attrIndex].variationValue[valueIndex])),
                    ),
                  )],
            ),
          ])
      ],
    ) ;
  }

  Widget productMoreDetails(){
    var textStyle = const TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16))
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.MARGIN_SIZE_EXTRA_LARGE),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40,),
              Text('Product Details',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),),
              const SizedBox(height: 18,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Edible Oil / Ghee Type'),
                        Text('Mustard Oil / Sarso Tel',style: textStyle,)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Edible Oil / Ghee Type'),
                        Text('Mustard Oil / Sarso Tel',style: textStyle,)
                      ],
                    ),
                  ),

                ],
              ),
              Container(height: 1,color: Colors.black26,margin: EdgeInsets.symmetric(vertical: 18),),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Edible Oil / Ghee Type'),
                        Text('Mustard Oil / Sarso Tel',style: textStyle,)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Edible Oil / Ghee Type'),
                        Text('Mustard Oil / Sarso Tel',style: textStyle,)
                      ],
                    ),
                  ),

                ],
              ),
              Container(height: 1,color: Colors.black26,margin: EdgeInsets.symmetric(vertical: 18),),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Edible Oil / Ghee Type'),
                        Text('Mustard Oil / Sarso Tel',style: textStyle,)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Edible Oil / Ghee Type'),
                        Text('Mustard Oil / Sarso Tel',style: textStyle,)
                      ],
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 18,),

            ],
          ),
        ),
      ),
    );
  }
}
