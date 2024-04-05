import 'package:flutter/material.dart';
import 'package:flyseas/provider/product_provider.dart';
import 'package:flyseas/util/color_resources.dart';
import 'package:provider/provider.dart';

import '../../provider/home_provider.dart';
import '../screens/home/dashboard_screen.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<ProductProvider>(builder: (context,cartProvider,child){
          return Visibility(
            visible: cartProvider.cartList.isNotEmpty,
            child: Positioned(
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle
                ),
                width: 16,
                height: 16,
                child: Center(child: Text(cartProvider.cartList.length>9 ? '9+':'${cartProvider.cartList.length}',style: TextStyle(fontSize: 8),)),
              ),
            ),
          );
        }),
        IconButton(onPressed: (){
          Provider.of<HomeProvider>(context,listen: false).updateHomePageIndex(1);
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  const DashboardScreen()));
        }, icon: const Icon(Icons.shopping_cart_outlined,color: ColorResources.BLACK,)),
      ],
    );
  }
}
