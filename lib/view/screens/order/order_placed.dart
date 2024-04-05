import 'package:flutter/material.dart';
import 'package:flyseas/provider/home_provider.dart';
import 'package:flyseas/provider/product_provider.dart';
import 'package:flyseas/view/screens/home/dashboard_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../util/color_resources.dart';
class OrderPlacedScreen extends StatefulWidget {
  final String orderId;
  const OrderPlacedScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();

}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> with TickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: (5)),
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductProvider>(context,listen: false).getCart();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Placed'),backgroundColor: ColorResources.gradientOne,),
      body: ListView(
        children: [
          Lottie.asset('assets/success_anim.json',
            controller: _controller,
            height: MediaQuery.of(context).size.height * .25,
            width: MediaQuery.of(context).size.width * .25,
            animate: true,
            repeat: true,
            fit: BoxFit.contain,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward().whenComplete(() {
                });
            },
          ),
          const SizedBox(height: 8,),
          const Center(child: Text('Order Placed Successfully with ')),
          const SizedBox(height: 4,),
          Center(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(widget.orderId),
          )),
          Container(
            margin: const EdgeInsets.all(8),
            child: ElevatedButton(onPressed: (){
              Provider.of<HomeProvider>(context,listen: false).updateHomePageIndex(0);
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  const DashboardScreen()));
            },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ColorResources.gradientOne)
                ),
                child: const Text('Go Back Home')),
          )
        ],
      ),
    );
  }
}
