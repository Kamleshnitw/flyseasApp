import 'package:flutter/material.dart';
import 'package:flyseas/view/screens/sub_category_screen/sub_category_screen.dart';

import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back_ios_outlined,color: Color(0xFF3B0B45),),
        actions: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width *.8,
            margin: EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
                border: Border.all(color: ColorResources.gradientOne),
                borderRadius: BorderRadius.all(Radius.circular(40))
            ),
            child: TextField(
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.mic,color: ColorResources.gradientOne,),
                  prefixIcon: Icon(Icons.search,color: ColorResources.gradientOne),
                  contentPadding: EdgeInsets.all(8.0),
                  hintText: 'Search...',
                  border: InputBorder.none
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
        child: GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: (1/1.5)
            ),
            itemCount: 21,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SubCategoryScreen()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(width: .5,color: Color(0xFFAAAAAA))
                  ),
                  margin: EdgeInsets.only(bottom: 16,left: 4,right: 4),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network('https://i2.wp.com/files.123freevectors.com/wp-content/original/154599-abstract-colorful-background.jpg',fit: BoxFit.cover,height: 100,)),
                        const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL,),
                        Text('Category Name',textAlign: TextAlign.center,),
                        const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL,),
                      ],

                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
