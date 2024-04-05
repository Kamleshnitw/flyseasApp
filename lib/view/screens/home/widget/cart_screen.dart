import 'package:flutter/material.dart';
import 'package:flyseas/util/color_resources.dart';
import 'package:flyseas/util/custom_snackbar.dart';
import 'package:flyseas/util/progress_dialog.dart';
import 'package:flyseas/view/screens/order/order_review.dart';
import 'package:provider/provider.dart';

import '../../../../provider/product_provider.dart';
import '../../../../util/custom_themes.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getData();
    });
  }

  getData() async {
    await Provider.of<ProductProvider>(context,listen: false).getCart();
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context,productProvider,child){
      return productProvider.cartLoading ? const CircularProgressIndicator() :
      productProvider.cartList.isNotEmpty ?
      Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.only(bottom: 65),
              itemCount: productProvider.cartList.length,
              itemBuilder: (context,index){
            var cartData = productProvider.cartList[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: .5,)
                        ),
                        width: 70,
                        height: 70,
                        child: Image.network(cartData.thumbnail,fit: BoxFit.cover,
                          errorBuilder: (context,object,stack){
                          return const Center(child: Text('No Image',style: TextStyle(fontSize: 10),));
                          })),
                    const SizedBox(width: 16,),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cartData.productName),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("₹ "+cartData.sellingPrice),
                                    const SizedBox(width: 8,),
                                    Text("₹ "+cartData.mrpPrice,style: const TextStyle(decoration: TextDecoration.lineThrough,color: Colors.black54),),
                                    Visibility(
                                      visible: (double.tryParse(cartData.discountPrice) ?? 0)>0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: ColorResources.gradientOne,
                                            borderRadius: BorderRadius.circular(4)
                                        ),
                                        margin: EdgeInsets.only(left: 8),
                                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                        child: Text('${cartData.discountType=='fixed' ? '₹' : ''} ${cartData.discountPrice} OFF',style: TextStyle(fontSize: 10,color: Colors.white),),
                                      ),
                                    )
                                  ],
                                ),
                                /*Row(
                                  children: [
                                    Text(cartData.discountType=="%" ? '%${cartData.discountPrice} OFF' :'₹ ${cartData.discountPrice} Save')
                                  ],
                                ),*/
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () async{
                                  if(cartData.quantity==1){
                                    //remove
                                    ProgressDialog.showLoadingDialog(context);
                                    await productProvider.deleteToCart(cartData.productId, cartData.combinationName).then((value) {
                                      ProgressDialog.closeLoadingDialog(context);
                                      productProvider.removeItemFromCart(index);
                                    });
                                  }
                                  else{
                                    //update
                                    int newQty = cartData.quantity-1;
                                    ProgressDialog.showLoadingDialog(context);
                                    await productProvider.updateToCart(cartData.productId, newQty,cartData.combinationName) .then((value){
                                      ProgressDialog.closeLoadingDialog(context);
                                      if(value){
                                        cartData.quantity = newQty;
                                        productProvider.updateCartQuantity();
                                        showCustomSnackBar("Product quantity update successfully.", context,isError: false);
                                      }
                                    });

                                  }
                                }, icon: const Icon(Icons.remove,color: ColorResources.gradientOne,),),
                                Text("${cartData.quantity}",style: titilliumBold,),
                                IconButton(onPressed: () async{
                                  // update Quantity
                                  int newQty = cartData.quantity+1;
                                  ProgressDialog.showLoadingDialog(context);
                                  await productProvider.updateToCart(cartData.productId, newQty,cartData.combinationName) .then((value){
                                    ProgressDialog.closeLoadingDialog(context);
                                    if(value){
                                      cartData.quantity = newQty;
                                      productProvider.updateCartQuantity();
                                      showCustomSnackBar("Product quantity update successfully.", context,isError: false);
                                    }
                                  });

                                }, icon: const Icon(Icons.add,color: ColorResources.gradientOne))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            );
          }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 8),
              width: MediaQuery.of(context).size.width * .9,
              height: 55,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  OrderReview(cartList: productProvider.cartList,)));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(ColorResources.gradientOne)
                ),
                child: Text('Proceed'),
              ),
            ),
          )
        ],
      ) : const Center(child: Text('Cart is Empty'),);
    });
  }
}
