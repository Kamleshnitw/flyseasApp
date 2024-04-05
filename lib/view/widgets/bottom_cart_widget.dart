import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/home_provider.dart';
import '../../provider/product_provider.dart';
import '../../util/color_resources.dart';
import '../screens/home/dashboard_screen.dart';

class BottomCartWidget extends StatelessWidget {
  const BottomCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context,productProvider,child){
      return Visibility(
          visible: productProvider.cartList.isNotEmpty,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                color: ColorResources.gradientOne,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8)
                )
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${productProvider.cartList.length} Item | ₹${productProvider.getCartTotal()} ',
                  style: TextStyle(color: Colors.white),),
                GestureDetector(
                  onTap: (){
                    Provider.of<HomeProvider>(context,listen: false).updateHomePageIndex(1);
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const DashboardScreen()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.shopping_cart_outlined,size: 18,color: Colors.white,),
                      const SizedBox(width: 8,),
                      Text('View Cart',style: TextStyle(color: Colors.white),)
                    ],
                  ),
                )

              ],
            ),
          ));
    },);
  }
}
