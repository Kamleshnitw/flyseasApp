import 'package:flutter/material.dart';

import '../../util/color_resources.dart';
import '../screens/kyc_screen/user_kyc_screen.dart';

class KYCSheet extends StatelessWidget {
  const KYCSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8))
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25,),
          const Text('Want to see flyseas price ?',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),),
          const SizedBox(height: 16,),
          const Text('Complete your KYC to view price'),
          const SizedBox(height: 8,),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 45,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ColorResources.gradientOne)
                ),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UserKYCScreen()));
                }, child: const Text('Complete KYC')),
          ),
          const SizedBox(height: 8,),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(ColorResources.WHITE),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(color: ColorResources.gradientOne)
                          )
                      )
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  }, child: const Text("I'll do it latter",style: TextStyle(color: ColorResources.gradientOne),)))

        ],
      ),
    );
  }

}
