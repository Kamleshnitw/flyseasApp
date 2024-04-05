import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/home_provider.dart';
import 'categories/bakery_widget.dart';
import 'categories/clothing_widget.dart';
import 'categories/electronic_widget.dart';
import 'categories/fmcg_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context,auth,child){
      if(auth.selectedCategory==1){
        return BakeryWidget();
      }
      else if(auth.selectedCategory==2){
        return FMCGWidget();
      }
      else if(auth.selectedCategory==3){
        return ClothingWidget();
      }
      else if(auth.selectedCategory==4){
        return ElectronicWidget();
      }
      else{
        return const SizedBox();
      }
    });
  }
}
