import 'package:flutter/material.dart';

class ProgressDialog {
  static final ProgressDialog _instance = ProgressDialog.internal();
  static bool _isLoading = false;
  ProgressDialog.internal();
  factory ProgressDialog() => _instance;

  static void closeLoadingDialog(BuildContext _context) {
    if (_isLoading) {
      Navigator.of(_context).pop();
      _isLoading = false;
    }
  }

  static void showLoadingDialog(BuildContext _context) async {
    _isLoading = true;
    await showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              )
            ],
          );
        });
  }

}