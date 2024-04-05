import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flyseas/util/custom_snackbar.dart';
import 'package:webview_flutter/webview_flutter.dart';
class PhonePePaymentScreen extends StatefulWidget {
  final String paymentUrl;
  final String from;
  const PhonePePaymentScreen({Key? key, required this.paymentUrl, required this.from}) : super(key: key);

  @override
  State<PhonePePaymentScreen> createState() => _PhonePePaymentScreenState();
}

class _PhonePePaymentScreenState extends State<PhonePePaymentScreen> {


  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, {"status": false, "order": "details"});
          return true;
        },
        child: WebView(
          initialUrl: widget.paymentUrl,
          onWebViewCreated: (controller) {
            _controller = controller;
          },
          javascriptMode: JavascriptMode.unrestricted,
          backgroundColor: const Color(0x00000000),
          onPageFinished: (url) {
            //https://flyseas.in/phonepe/redirectUrl?merchant_transaction_id=20230827-09351385&order_id=47

            // for wallet
            //https://flyseas.in/admin/api/phonepe/walletRedirectUrl?merchant_transaction_id=20230911-22491251&user_id=7

            //print(url.contains("https://flyseas.in/admin/api/phonepe/redirectUrl"));
            if (url.contains("https://flyseas.in/admin/api/phonepe/redirectUrl") ||
                url.contains("https://flyseas.in/admin/api/phonepe/walletRedirectUrl")) {
                parseString();
            }
            print("finish url ==== " + url);
          },
          onPageStarted: (url) {
            print("start url ==== " + url);
          },
          onWebResourceError: (error) {

          },
          onProgress: (progress) {

          },
          navigationDelegate: (request) {
            print("delegate url ==== " + request.url);
            if (request.url.startsWith('https://mercury-t2.phonepe.com/transact/pg')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }

  void parseString(){
    _controller?.runJavascriptReturningResult('''
          var preTag = document.querySelector('pre');
          if (preTag) {
            var jsonData = preTag.innerText;
            jsonData;
          } else {
            null;
          }
        ''').then((value) {
        // Handle the extracted JSON data here
        String extractedJson = value.replaceAll('\\', ''); // Remove escape characters
        print('Extracted JSON: $extractedJson');
        String data = json.decode(value);
        Map jsonData = jsonDecode(data);
        Navigator.pop(context, {"status": jsonData['success'], "order_id": jsonData['order_id'],'transaction_id':jsonData['transaction_id']});

    });
  }

}
