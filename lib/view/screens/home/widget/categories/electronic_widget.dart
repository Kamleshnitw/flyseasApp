import 'package:flutter/material.dart';

class ElectronicWidget extends StatefulWidget {
  const ElectronicWidget({Key? key}) : super(key: key);

  @override
  State<ElectronicWidget> createState() => _ElectronicWidgetState();
}

class _ElectronicWidgetState extends State<ElectronicWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Electronic Coming Soon'),
    );
  }
}
