import 'package:flutter/material.dart';

class ClothingWidget extends StatefulWidget {
  const ClothingWidget({Key? key}) : super(key: key);

  @override
  State<ClothingWidget> createState() => _ClothingWidgetState();
}

class _ClothingWidgetState extends State<ClothingWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Clothing Coming Soon'),
    );
  }
}
