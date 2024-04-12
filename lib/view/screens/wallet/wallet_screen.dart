import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyseas/provider/balance_provider.dart';
import 'package:flyseas/provider/order_provider.dart';
import 'package:flyseas/util/app_constants.dart';
import 'package:flyseas/util/color_resources.dart';
import 'package:provider/provider.dart';

import '../../../data/model/base/response_model.dart';
import '../../../util/custom_snackbar.dart';
import '../../../util/custom_themes.dart';
import '../payment/phone_pe_payment_web_view.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  TextEditingController amountController = TextEditingController();
  //List<int> selectedAmounts = [];
  int selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${AppConstants.appName} Wallet'),
        ),
      body: Consumer<BalanceProvider>(builder: (context,balanceProvider,child){
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.network('https://static-00.iconduck.com/assets.00/wallet-icon-2048x2048-9rmek6d6.png',height: 60,
                      width: 60,),
                    const SizedBox(width: 16,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Wallet Balance'),
                        Text('₹ ${balanceProvider.balance}',style: TextStyle(fontSize: 18,color: ColorResources.gradientOne),)
                      ],
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: const Text('Use ${AppConstants.appName} Wallet For Hassle Free Payments on Checkout',style: TextStyle(fontSize: 12),),
            ),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Add Money',style: Theme.of(context).textTheme.headline6,),
            ),
            //const SizedBox(height: 16,),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    const SizedBox(height: 16,),
                    Wrap(
                      spacing: 8.0,
                      children: [3000, 5000, 8000, 10000].map((amount) {
                        bool isSelected = selectedAmount == amount;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              setState(() {
                                selectedAmount = amount;
                              });
                              amountController.text = amount.toString();
                            });
                          },
                          child: Chip(
                            backgroundColor: isSelected ? ColorResources.gradientOne : Colors.white60,
                            label: Text(
                              '+₹$amount',
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            padding: EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(
                                color: isSelected ? ColorResources.gradientOne : Colors.grey,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16,),
                    SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(onPressed: (){
                          rechargeWallet();
                        }, child: const Text('Add Money'))),
                    const SizedBox(height: 8,),

                  ],

                ),
              ),
            ),
            const SizedBox(height: 16,),
            Text('Wallet Transaction',style: Theme.of(context).textTheme.headline6,),
            const SizedBox(height: 5,),
            ListView.builder(
                itemCount: balanceProvider.balanceList.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context,index){
                  var walletData = balanceProvider.balanceList[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black12
                                ),
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: Stack(
                                    children: [
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text('₹',style: titleHeader,)),
                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(walletData.type=="debit" ? '-': '+'),
                                          ))

                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(walletData.type=="debit" ? 'Order Placed' :'Amount Deposit'),
                                  Text(walletData.date)
                                ],
                              ),
                            ],
                          ),
                          Text("${walletData.type=="debit" ?'-' :'+'}₹${walletData.amount}",
                            style: TextStyle(color: walletData.type=="debit" ? Colors.red : Colors.green),)
                        ],
                      ),
                    ),
                  );
                })
          ],
        );
      },),
    );
  }

  void rechargeWallet() async {
    String amount = amountController.text.toString();
    if(amount.isEmpty){
      showCustomSnackBar("Please Enter Amount First", context);
      return;
    }
    if((int.tryParse(amount) ?? 0)<1999){
      showCustomSnackBar("Minimum Recharge Amount ₹1999 ", context);
      return;
    }
    var orderProvider = Provider.of<BalanceProvider>(context,listen: false);
    // get Online URL First
    ResponseModel re = await orderProvider.rechargeWallet(amount);
    if(re.isSuccess){
      //open web view payment
      if(re.message.isEmpty){
        showCustomSnackBar("Url Not Found", context);
        return;
      }
      var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>
          PhonePePaymentScreen(paymentUrl: re.message,from: "wallet",)));

      if(result!=null){
        if(result is Map<String,dynamic>){
          // then check data
          if(result['status']){
            showCustomSnackBar("Recharge Successful", context,isError: false);
            Provider.of<BalanceProvider>(context,listen: false).getBalanceHistory();
            Future.delayed(const Duration(seconds: 1)).then((value) {
              //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>DashboardScreen()),(route)=>false);
              //Navigator.push(context, MaterialPageRoute(builder: (context) =>  OrderPlacedScreen(orderId: result['order_id'])));
            });
          }else{
            showCustomSnackBar("Payment Failed", context);
          }

        }
        else{
          // no data
          showCustomSnackBar("Payment Data not found", context);
        }
      }else{
        // handle error data
        showCustomSnackBar("Payment Error", context);
      }



    }
    else{
      showCustomSnackBar(re.message, context);
    }

  }
}
