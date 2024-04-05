import 'package:flutter/material.dart';
import 'package:flyseas/provider/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import 'category_wise_product_screen.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        title: Text('Categories',style: TextStyle(color: ColorResources.gradientOne,),),
      ),
      body: Consumer<HomeProvider>(builder: (context,homeProvider,child){
        return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: (1/1.38)
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
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(width: .5,color: Color(0xFFAAAAAA))
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(homeProvider.homeCategory[index].thumbnailImage,
                              fit: BoxFit.cover,height: 100,width: MediaQuery.of(context).size.width/1.38,)),
                        const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL,),
                        Text(homeProvider.homeCategory[index].name,maxLines:1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize:12,fontWeight: FontWeight.w600),),
                        //const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL,),
                      ],

                    ),
                  ),
                ),
              );
            }
        );
      },),
    );
  }
}
