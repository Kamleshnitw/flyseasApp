import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyseas/util/color_resources.dart';
import 'package:flyseas/util/images.dart';

class KYCScreen extends StatefulWidget {
  const KYCScreen({Key? key}) : super(key: key);

  @override
  State<KYCScreen> createState() => _KYCScreenState();
}

class _KYCScreenState extends State<KYCScreen> {

  List<String> documentList = ["GST Certificate",
  "Udyog Aadhar / UDYAM","FSSAI Registration (Food License)","Current Account Cheque","Shop & EStablishment License",
  "Student I'd Card","Other Shop Document","I don’t have any document"];

  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Color(0xFFFFE8F5), // Note RED here
      ),
    );
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: ListView(
          children: [
            Container(
              color: Color(0xFFFFE8F5),
              height: 120,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.navigate_before),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Complete Shop’s KYC'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Color(0xFFFC57B7),
              padding: EdgeInsets.all(16),
              child: const Text('Upload Any 1 Document',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),),
            ),
            ListView.builder(
                itemCount: documentList.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context,index){
              return Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1,color: Colors.black12))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                      child: Text(documentList[index],style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                    ),
                    GestureDetector(
                      onTap: (){
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return imagePickWidget();
                          },isDismissible: false,barrierColor: Colors.white.withOpacity(0),backgroundColor: Colors.transparent,);
                      },
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorResources.gradientOne
                        ),
                        child: Icon(Icons.arrow_upward,size: 16,color: Colors.white,),
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.all(8),
                      ),
                    )
                  ],
                ),

              );
            }),
            const SizedBox(height: 40,),
            Row(
              children: [
              Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.all(ColorResources.gradientOne),
              value: isChecked,
              shape: CircleBorder(),
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text('The bussiness name will be as per  your licence document and the '
                        'same will reflect in all your transactions with Flyseas.',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600,color: Colors.black26),),
                  ),
                ),
              ],
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16,vertical: 40),
              color: Color(0xFFFFE8F5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 25),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                      ),
                      height: 40,
                      width: 40,
                      child: Image.asset(Images.phoneIcon),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text('Need any Help?\nContact Us',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: ColorResources.gradientOne),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.navigate_next_sharp,color: ColorResources.gradientOne,),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget imagePickWidget(){
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      decoration: const BoxDecoration(
          color: Color(0xFFFFE8F5),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8))
      ),
      child: Column(
        children: [
          const SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white

                ),
                child: const Icon(Icons.camera_alt_outlined,size: 40,color: ColorResources.gradientOne,),
              ),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white

                ),
                child: Icon(Icons.photo_outlined,size: 40,color: ColorResources.gradientOne,),
              )
            ],
          ),
          const SizedBox(height: 8,),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Using Camera, Gallery or Files.',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.black45),),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * .6,
              child: ElevatedButton(onPressed: (){}, child: Text('Upload',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(ColorResources.gradientOne)
              ),)),
          const SizedBox(height: 8,),
          Text('Gsy Certificate verifies in 10 mins.')
        ],
      ),
    );
  }


}
