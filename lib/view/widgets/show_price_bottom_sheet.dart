import 'package:flutter/material.dart';

import '../../util/color_resources.dart';

class ShowPriceBottomSheet extends StatefulWidget {
  const ShowPriceBottomSheet({Key? key}) : super(key: key);

  @override
  State<ShowPriceBottomSheet> createState() => _ShowPriceBottomSheetState();
}

class _ShowPriceBottomSheetState extends State<ShowPriceBottomSheet> {
  @override
  Widget build(BuildContext context) {
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
