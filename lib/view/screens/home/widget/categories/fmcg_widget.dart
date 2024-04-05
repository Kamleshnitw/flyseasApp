import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flyseas/util/color_resources.dart';
import 'package:flyseas/util/dimensions.dart';
import 'package:flyseas/util/images.dart';
import 'package:flyseas/view/screens/all_category_screen/category_screen.dart';
import 'package:flyseas/view/screens/kyc_screen/kyc_screen.dart';
import 'package:flyseas/view/widgets/category_bottom_sheet.dart';

import '../../../../../util/custom_themes.dart';
import '../../../sub_category_screen/sub_category_screen.dart';

class FMCGWidget extends StatefulWidget {
  const FMCGWidget({Key? key}) : super(key: key);

  @override
  State<FMCGWidget> createState() => _FMCGWidgetState();
}

class _FMCGWidgetState extends State<FMCGWidget> {

  List<String> sliderList = [
    "https://i2.wp.com/files.123freevectors.com/wp-content/original/154599-abstract-colorful-background.jpg",
    "https://i2.wp.com/files.123freevectors.com/wp-content/original/154599-abstract-colorful-background.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return 2.isEven ? SizedBox(child: Text('Coming Soon'),): ListView(
      children: [
        const Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Text('Namaste',style: TextStyle(fontSize: Dimensions.FONT_SIZE_OVER_LARGE,fontWeight: FontWeight.w700),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Text('Prakash Singh !',style: TextStyle(fontSize: Dimensions.FONT_SIZE_OVER_LARGE,fontWeight: FontWeight.w400,color: ColorResources.gradientOne)),
        ),
        Container(
          height: 40,
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
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Color(0xFFFFE8F5)
            ),
            margin: EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_DEFAULT,vertical: 12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 12),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Complete Shop KYC to:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: ColorResources.gradientOne),),
                      SizedBox(height: Dimensions.MARGIN_SIZE_SMALL,),
                      Text('Check best margin on products.',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400)),
                      Text('Place successful orders.',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400)),
                      SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const KYCScreen()));
                            },
                        child: Container(
                          height: 34,
                          width: MediaQuery.of(context).size.width * .68,
                          decoration: BoxDecoration(
                            gradient:  const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorResources.gradientOne,
                                  ColorResources.gradientTwo,
                                ]
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(child: Text('Upload Certificate',style: TextStyle(color: ColorResources.WHITE,fontSize: 14,fontWeight: FontWeight.w700),)),
                        ),
                      )

                    ],
                  ),
                  Positioned(
                      right: 0,
                      child: Image.asset(Images.kycIcon,height: 125,width: 125,)),
                ],
              ),
            )),
        /*CarouselSlider.builder(
          itemCount: sliderList.length,
          options: CarouselOptions(
            //enlargeCenterPage: true,
            height: 160,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 6),
            reverse: false,
            viewportFraction: .99,
          ),
          itemBuilder: (context, i, id) {
            //for onTap to redirect to another screen
            return GestureDetector(
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
                //ClipRRect for image border radius
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    sliderList[i],
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onTap: () {
                //var url = imageList[i];
              },
            );
          },
        ),*/
        Container(
          height: 160,
          margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sliderList.length,
              itemBuilder: (context,index){
            return Container(
              width: 280,
              margin: EdgeInsets.only(right: Dimensions.MARGIN_SIZE_DEFAULT),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16))
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(sliderList[index],fit: BoxFit.cover,)),
            );
          }),
        ),
        const SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_DEFAULT,vertical: Dimensions.MARGIN_SIZE_SMALL),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New Arrivals',style: titleHeaderHome,),
              Row(
                children: [
                  Text('View All',style: TextStyle(fontSize: 11,color: ColorResources.gradientOne,fontWeight: FontWeight.w600),),
                  Icon(Icons.navigate_next,color: ColorResources.gradientOne,size: 16,)
                ],
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          height: 200,
          child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemBuilder: (context,index){
                return Container(
                  width: 140,
                  margin: EdgeInsets.only(right: 4),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(sliderList[0],fit: BoxFit.cover,)),
                  ),
                );
              }),
        ),
        const SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_DEFAULT,vertical: Dimensions.MARGIN_SIZE_SMALL),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Top Brands',style: titleHeaderHome,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
          child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: (1/1.7)
              ),
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                      color: Theme.of(context).highlightColor,
                      boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.0),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      )],
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(sliderList[0],fit: BoxFit.cover,)),
                    ),
                  ),
                );
              }
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_DEFAULT,vertical: Dimensions.MARGIN_SIZE_SMALL),
          height: 160,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(sliderList[0],fit: BoxFit.cover,),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_DEFAULT,vertical: Dimensions.MARGIN_SIZE_SMALL),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Top Categories',style: titleHeaderHome,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
          child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: (1/1.5)
              ),
              itemCount: 9,
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
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(sliderList[0],fit: BoxFit.cover,height: 100,)),
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
        GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AllCategoryScreen()));
          },
          child: Container(
            height: 54,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(Dimensions.MARGIN_SIZE_DEFAULT),
            decoration: BoxDecoration(
              gradient:  const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorResources.gradientOne,
                    ColorResources.gradientTwo,
                  ]
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(child: Text('VIEW ALL CATEGORIES',style: TextStyle(color: ColorResources.WHITE,fontSize: 16,fontWeight: FontWeight.w700),)),
          ),
        ),

      ],
    );
  }

  Widget getProductWidget(){
    return Stack(
      children: [
        Container(
          color: Colors.white38,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0,top: 10.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://www.seekpng.com/png/detail/18-189790_free-png-potato-png-images-transparent-potatoes.png',height: 90,width: 140,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Product Name'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Product Qty'),
                    ),
                    Container(
                      width:140,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('Qty'),
                                Text('Qty'),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.add),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0,
                                  ),]

                              ),
                            )
                          ],
                        ),
                      ),
                    )


                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: ColorResources.gradientOne,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Center(child: Text('16%\nOFF',overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(fontSize: 11,color: Colors.white),)),
          ),
        )
      ],
    );
  }
}
