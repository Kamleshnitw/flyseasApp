import 'package:flutter/material.dart';
import 'package:flyseas/util/images.dart';

import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {

  int selectedIndex= 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: LayoutBuilder(
              builder: (context, constraints) => Container(
                color: Color(0xFFFDFAFC),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      selectedIndex = index;
                      setState(() {

                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(right: BorderSide(color: selectedIndex==index ? ColorResources.gradientOne: Colors.transparent,width: 2))
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(Images.catClothIcon),
                            radius: 30,
                          ),
                          const SizedBox(height: 8,),
                          Text('Clothes',style: TextStyle(fontSize: 10,fontWeight: selectedIndex==index ? FontWeight.w500 :FontWeight.w400,color: selectedIndex==index ? ColorResources.gradientOne:Color(0xFF666666)),)
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: LayoutBuilder(
              builder: (context, constraints) => Container(
                color: Colors.black12,
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (1/1.55)
                    ),
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(right: 1,bottom: 1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 5),
                                    child: Image.network('https://pngimg.com/uploads/broccoli/broccoli_PNG72907.png',fit: BoxFit.cover,height: 100,),
                                  ),
                                  elevation: 1,
                                ),
                                const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Dhara Kachi Ghani Mustard Oil / Sarso Tel',textAlign: TextAlign.start,maxLines: 2,overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 10),),
                                    GestureDetector(
                                      onTap: (){
                                        showModalBottomSheet<void>(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return showPriceWidgetSheet();
                                          },isDismissible: false,barrierColor: Colors.white.withOpacity(0),backgroundColor: Colors.transparent,);

                                      },
                                      child: Container(
                                        child: Text('View Price',maxLines: 1,style: TextStyle(fontSize: 8),textAlign: TextAlign.center,),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: ColorResources.gradientOne),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        margin: EdgeInsets.only(top: 8),
                                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 6),
                                      ),
                                    )
                                  ],
                                ),
                              ],

                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showPriceWidgetSheet(){
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8))
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25,),
          Text('Want to see flyseas price ?',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),),
          SizedBox(height: 16,),
          Text('Complete your KYC to view price'),
          SizedBox(height: 8,),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 45,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(ColorResources.gradientOne)
                ),
                onPressed: (){}, child: Text('Complete KYC')),
          ),
          SizedBox(height: 8,),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(ColorResources.WHITE),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(color: ColorResources.gradientOne)
                          )
                      )
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("I'll do it latter",style: TextStyle(color: ColorResources.gradientOne),)))

        ],
      ),
    );
  }
}
