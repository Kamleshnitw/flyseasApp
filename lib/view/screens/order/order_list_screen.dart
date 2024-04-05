import 'package:flutter/material.dart';
import 'package:flyseas/provider/order_provider.dart';
import 'package:flyseas/view/screens/order/order_detail_screen.dart';
import 'package:provider/provider.dart';

import '../../../util/color_resources.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getData();
    });
  }

  getData() async {
    await Provider.of<OrderProvider>(context,listen: false).getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Orders'),backgroundColor: ColorResources.gradientOne,),
      body: Consumer<OrderProvider>(builder: (context,orderProvider,child){
        return orderProvider.isOrderLoading ? Center(child: CircularProgressIndicator(),) :ListView.builder(
            itemCount: orderProvider.orderListData.length,
            itemBuilder: (context,index){
              var orderData = orderProvider.orderListData[index];
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderDetailScreen(orderId: orderData.orderId)));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(orderData.orderId),
                        Text(orderData.orderStatus),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Items ${orderData.productCount}"),
                        Text("₹ ${orderData.grandAmount}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(orderData.orderTime),
                        Text(orderData.paymentStatus),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      }),
    );
  }
}
