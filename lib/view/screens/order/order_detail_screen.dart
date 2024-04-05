import 'package:flutter/material.dart';
import 'package:flyseas/util/custom_themes.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../provider/order_provider.dart';
import '../../../util/color_resources.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;
  const OrderDetailScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getData();
    });
  }

  getData() async {
    await Provider.of<OrderProvider>(context,listen: false).getOrderDetail(widget.orderId);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Details'),backgroundColor: ColorResources.gradientOne,),
      body: Consumer<OrderProvider>(builder: (context,orderProvider,child){
        return orderProvider.isOrderDetailLoading ?
        Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))) :
        orderProvider.orderDetailResponse!=null ?
        ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(orderProvider.orderDetailResponse!.orderDetail.orderId),
                        Text(orderProvider.orderDetailResponse!.orderDetail.orderStatus),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Item Count ${orderProvider.orderListData.length}"),
                        Text("₹ ${orderProvider.orderDetailResponse!.orderDetail.totalAmount}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(orderProvider.orderDetailResponse!.orderDetail.orderTime),
                        Text(orderProvider.orderDetailResponse!.orderDetail.paymentStatus),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product List',style: titleHeaderHome,),
                    ListView.builder(
                        itemCount: orderProvider.orderDetailResponse!.orderDetail.productList.length ,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context,index){
                          var productData = orderProvider.orderDetailResponse!.orderDetail.productList[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: .5,)
                                  ),
                                  width: 60,
                                  height: 60,
                                  child: Image.network(productData.thumbnail,fit: BoxFit.cover,
                                      errorBuilder: (context,object,stack){
                                        return const Center(child: Text('No Image',style: TextStyle(fontSize: 10),));
                                      })),
                              const SizedBox(width: 16,),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(productData.productName),
                                      Row(
                                        children: [
                                          Text("₹ "+productData.sellingPrice),
                                          const SizedBox(width: 8,),
                                          Text("₹ "+productData.mrpPrice,style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.black54),),
                                        ],
                                      ),
                                      Text("Qty : ${productData.quantity}"),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );})
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Download Invoice'),
                    IconButton(onPressed: (){
                      if(orderProvider.orderDetailResponse!.orderDetail.invoice.isNotEmpty){
                        _launchUrl(orderProvider.orderDetailResponse!.orderDetail.invoice);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Invoice Not Created"),
                          backgroundColor: Colors.amber,
                        ));
                      }
                    }, icon: Icon(Icons.download))
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price Details',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('MRP Price'),
                                Text("₹ ${orderProvider.totalAmount}"),
                              ],
                            ),
                           /* const SizedBox(height: 8,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Selling Price'),
                                Text("₹ ${orderProvider.discountAmount}"),
                              ],
                            ),*/
                            const SizedBox(height: 8,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Discount'),
                                Text("₹ ${orderProvider.discount}"),
                              ],
                            ),
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
                                Text("₹ ${orderProvider.orderDetailResponse!.orderDetail.orderId}"),
                              ],) : SizedBox(),
                            const SizedBox(height: 8,),
                            Divider(height: 1,color: Colors.black54,),
                            const SizedBox(height: 8,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('To Pay'),
                                Text("₹ ${orderProvider.orderDetailResponse!.orderDetail.grandAmount}"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )

          ],
        ) :
        const Center(child: Text('Ops ! Something Wrong'),);
      }),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri,mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
