import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flyseas/data/model/base/response_model.dart';
import 'package:flyseas/provider/home_provider.dart';
import 'package:flyseas/provider/order_provider.dart';
import 'package:flyseas/util/custom_themes.dart';
import 'package:flyseas/view/screens/order/order_placed.dart';
import 'package:flyseas/view/screens/payment/phone_pe_payment_web_view.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/cart_list_response.dart';
import '../../../data/model/response/coupon_list_response.dart';
import '../../../provider/balance_provider.dart';
import '../../../provider/location_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/custom_snackbar.dart';
import '../../../util/dimensions.dart';
import '../address/add_new_address_screen.dart';
import '../wallet/wallet_screen.dart';

class OrderReview extends StatefulWidget {
  final List<CartList> cartList;
  const OrderReview({Key? key, required this.cartList}) : super(key: key);

  @override
  State<OrderReview> createState() => _OrderReviewState();
}

enum PaymentOption {
  COD, // Cash on Delivery
  Online, // Online Payment,
  Wallet, // Online Payment,
}

class _OrderReviewState extends State<OrderReview> {

  var totalAmount = 0.0;
  var discountAmount = 0.0;
  var discount = 0.0;
  //var couponDiscount = 0.0;
  PaymentOption _selectedOption = PaymentOption.Wallet;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getData();
      for (var element in widget.cartList) {
        totalAmount+= element.quantity*double.parse(element.mrpPrice);
        discountAmount+= element.quantity*double.parse(element.sellingPrice);
      }

      discount = totalAmount-discountAmount;

    });
  }

  getData() async {
    await Provider.of<OrderProvider>(context,listen: false).getCouponList();
    await Provider.of<LocationProvider>(context,listen: false).initAddressList(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Review'),backgroundColor: ColorResources.gradientOne,),
      body: Consumer<OrderProvider>(builder: (context,orderProvider,child){
        return ListView(
        padding: const EdgeInsets.all(8),
        children: [
          ListView.builder(
              itemCount: widget.cartList.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context,index){
                var cartData = widget.cartList[index];
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
                                  children: [
                                    Text("₹ "+cartData.sellingPrice),
                                    const SizedBox(width: 8,),
                                    Text("₹ "+cartData.mrpPrice,style: const TextStyle(decoration: TextDecoration.lineThrough,color: Colors.black54),),
                                  ],
                                ),
                                Text("Qty : ${cartData.quantity}"),
                              ],
                            ))
                      ],
                    ),
                  ),
                );
              }),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  orderProvider.appliedCouponCode.isEmpty ? Row(
                    children: const [
                      Icon(Icons.local_offer),
                      SizedBox(width: 8,),
                      Text('Check Offers')
                    ],
                  ) : Text(orderProvider.appliedCouponCode),
                  orderProvider.couponDiscount== 0.0 ? TextButton(onPressed: (){
                    if(orderProvider.couponList.isEmpty){
                      showCustomSnackBar("No Coupons Available", context);
                      return;
                    }
                    _showCouponSheet(orderProvider.couponList);
                  }, child: Text('Apply Coupon')) : TextButton(onPressed: (){
                      orderProvider.removeCoupon();
                  }, child: Text('Remove Coupon',style: TextStyle(color: Colors.red),))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Address',style: titleHeader,),
                TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AddNewAddressScreen(address: null,fromCheckout: true,)));
                }, child: Text('Add Address'))
              ],
            ),
          ),
          Consumer<LocationProvider>(builder: (context,locationProvider,child){
            return SizedBox(
              height: locationProvider.addressList.isNotEmpty ? 100 :0,
              child: ListView.builder(
                  itemCount: locationProvider.addressList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    var addressModel = locationProvider.addressList[index];
                    return InkWell(
                      onTap: (){
                        locationProvider.updateSelectedAddress(index);
                      },
                      child: Container(
                        height: 100,
                        width: 220,
                        child:  Card(
                          shape: addressModel.isSelected
                              ?  const RoundedRectangleBorder(
                              side: BorderSide(color: ColorResources.gradientOne))
                              : null,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on, color: Theme.of(context).primaryColor, size: 16),
                                        const SizedBox(width: Dimensions.MARGIN_SIZE_SMALL,),
                                        Expanded(
                                          child: Text(
                                            "${addressModel.address} ${addressModel.cityName} ${addressModel.stateName} - ${addressModel.pincode}",
                                            style: robotoRegular.copyWith(color: ColorResources.getTextTitle(context), fontSize: Dimensions.FONT_SIZE_SMALL),
                                            maxLines: 2,overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                                  ],
                                ),
                              ),
                              addressModel.isSelected ? const Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Icon(Icons.check_box,color: ColorResources.gradientOne)) : SizedBox()
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price Details',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('MRP Price (${widget.cartList.length} Item)'),
                      Text("₹ $totalAmount"),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount'),
                      Text("- ₹ $discount"),
                    ],
                  ),
                  /*const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Selling Price'),
                      Text("₹ $discountAmount"),
                    ],
                  ),*/
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Charge'),
                      Text("₹ 0"),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  orderProvider.couponDiscount!=0 ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text('Coupon Discount'),
                    Text("₹ ${orderProvider.couponDiscount}"),
                  ],) : SizedBox(),
                  const SizedBox(height: 8,),
                  Divider(height: 1,color: Colors.black54,),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('To Pay'),
                      Text("₹ ${discountAmount-orderProvider.couponDiscount}"),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Text('Payment Type'),

          Visibility(
            visible: false,
            child: RadioListTile<PaymentOption>(
              title: Text('Cash on Delivery'),
              value: PaymentOption.COD,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
          ),
          Visibility(
            visible: false,
            child: RadioListTile<PaymentOption>(
              title: Text('Online Payment'),
              value: PaymentOption.Online,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
          ),

          Consumer<BalanceProvider>(builder: (context,balanceProvider,child){
            return Column(
              children: [
                RadioListTile<PaymentOption>(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Flyseas Wallet'),
                      Text('₹ ${balanceProvider.balance}')
                    ],
                  ),
                  value: PaymentOption.Wallet,
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                ),

                /*ListTile(
                  leading: const Icon(Icons.account_balance_wallet_outlined,size: 18,color: ColorResources.gradientOne),
                  title: const Text("Flyseas Wallet Balance",style: TextStyle(color: ColorResources.gradientOne)),
                  trailing: Text('₹ ${balanceProvider.balance}'),
                  onTap: (){
                  },
                ),*/
                const SizedBox(height: 8,),
                Visibility(
                  visible: balanceProvider.balance < (discountAmount-orderProvider.couponDiscount),
                  child: ElevatedButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WalletScreen()));
                  }, child: const Text('Recharge Wallet')),
                )
              ],
            );
          }),


          SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            height: 55,
            child: ElevatedButton(
              onPressed: (){
                if(Provider.of<LocationProvider>(context, listen: false).getSelectedAddress()==null){
                  showCustomSnackBar("Please Pick An Address", context);
                  return;
                }
                if(Provider.of<BalanceProvider>(context, listen: false).balance < (discountAmount-orderProvider.couponDiscount)){
                  showCustomSnackBar("Please Recharge Your Wallet", context);
                  return;
                }

                placeOrder(orderProvider);


              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(ColorResources.gradientOne)
              ),
              child: const Text('Confirm Order'),
            ),
          )
        ],
      ); },
    ));
  }

  void placeOrder(OrderProvider orderProvider) async{
    Map<String,dynamic> orderDetails = {};

    List<Map<String,dynamic>> productData = [];

    for (var element in widget.cartList) {
      Map<String,dynamic> product = {};
      product['product_id'] = element.productId;
      product['product_name'] = element.productName;
      product['thumbnail'] = element.thumbnail;
      product['quantity'] = element.quantity;
      product['purchase_price'] = element.purchasePrice;
      product['selling_price'] = element.sellingPrice;
      product['mrp_price'] = element.mrpPrice;
      product['discount_price'] = element.discountPrice;
      product['discount_type'] = element.discountType;
      product['combination_name'] = element.combinationName;
      product['hsn_code'] = element.hsnCode ?? "N/A";
      product['gst'] = element.gst;
      product['status'] = "Pending";
      productData.add(product);
    }

      orderDetails['product_details'] = jsonEncode(productData);
      orderDetails['total_amount'] = totalAmount;
      orderDetails['coupon_code'] = orderProvider.appliedCouponCode;
      orderDetails['coupon_discount'] = orderProvider.couponDiscount;
      orderDetails['grand_amount'] = discountAmount;
      if(orderProvider.couponDiscount>0){
        orderDetails['grand_amount'] = discountAmount-orderProvider.couponDiscount;
      }
      orderDetails['payment_type'] = _selectedOption.name==PaymentOption.Wallet.name ? 'cash' : 'online';
      orderDetails['payment_status'] = 'paid';
      orderDetails['order_status'] = 'Pending';
      orderDetails['payment_details'] = '';
      orderDetails['address_id'] = Provider.of<LocationProvider>(context, listen: false).getSelectedAddress()!.id.toString();

    if(_selectedOption.name==PaymentOption.Wallet.name){
      orderProvider.placeBakeryOrder(orderDetails).then((value) {
        if(value.isSuccess){
          orderProvider.removeCoupon();
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  OrderPlacedScreen(orderId: value.message)));
        }
        showCustomSnackBar(value.message, context,isError: !value.isSuccess);
      });

    }else{
      // get Online URL First
      ResponseModel re = await orderProvider.initOnlinePayment(orderDetails);
      if(re.isSuccess){
        //open web view payment
        if(re.message.isEmpty){
          showCustomSnackBar("Url Not Found", context);
          return;
        }
        var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>
            PhonePePaymentScreen(paymentUrl: re.message,from: "order",)));

        if(result!=null){
          if(result is Map<String,dynamic>){
            // then check data
            if(result['status']){
              showCustomSnackBar("Payment Success", context,isError: false);
              Provider.of<HomeProvider>(context,listen: false).updateHomePageIndex(0);
              Future.delayed(const Duration(seconds: 1)).then((value) {
                //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>DashboardScreen()),(route)=>false);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  OrderPlacedScreen(orderId: result['order_id'])));
              });


            }else{
              showCustomSnackBar("Payment Failed", context);
            }

          }
          else{
            // no data
            showCustomSnackBar("Payment Data not found", context);
          }
        }else{
          // handle error data
          showCustomSnackBar("Payment Error", context);
        }



      }
      else{
        showCustomSnackBar(re.message, context);
      }

    }


  }

  _showCouponSheet(List<CouponList> couponList){
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
            child: ListView.builder(
                itemCount: couponList.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  var couponData = couponList[index];
                  return GestureDetector(
                    onTap: (){

                    },
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image.network(couponData.banner,height: 60,width: 60,)),
                                const SizedBox(width: 8,),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(couponData.couponName),
                                      Text(couponData.shortDescription,maxLines: 2,overflow: TextOverflow.ellipsis,),
                                      Text('Applied From ${couponData.startDate} to ${couponData.endDate}'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: TextButton(onPressed: (){
                                Navigator.pop(context);
                                //ProgressDialog.showLoadingDialog(context);
                                Provider.of<OrderProvider>(context,listen: false).applyCoupon(couponData.couponName).then((value) {
                                  //ProgressDialog.closeLoadingDialog(context);
                                });

                              }, child: const Text('APPLY')))
                        ],
                      ),
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
