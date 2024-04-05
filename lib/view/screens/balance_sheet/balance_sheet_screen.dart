import 'package:flutter/material.dart';
import 'package:flyseas/provider/balance_provider.dart';
import 'package:flyseas/util/custom_themes.dart';
import 'package:flyseas/util/dimensions.dart';
import 'package:provider/provider.dart';

import '../../../util/color_resources.dart';

class BalanceSheetScreen extends StatefulWidget {
  const BalanceSheetScreen({Key? key}) : super(key: key);

  @override
  State<BalanceSheetScreen> createState() => _BalanceSheetScreenState();
}

class _BalanceSheetScreenState extends State<BalanceSheetScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getData();
    });

  }

  getData() async {
    await Provider.of<BalanceProvider>(context,listen: false).getBalanceHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BalanceSheet'),backgroundColor: ColorResources.gradientOne,),
      backgroundColor: const Color(0xFFFFE8F5),
      body: Consumer<BalanceProvider>(builder: (context,balanceProvider,child){
        return ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Balance',style: TextStyle(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,fontWeight: FontWeight.w600),),
                    Text('${balanceProvider.balance.abs()} ${balanceProvider.balance>0? '(Advance)' :'(Due)'}'),
                  ],
                ),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: balanceProvider.balanceList.length,
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
}
