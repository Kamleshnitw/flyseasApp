import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/custom_themes.dart';
import '../../../util/dimensions.dart';
import '../../provider/home_provider.dart';
import '../screens/auth_screen/auth_screen.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 300,
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [

          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Text('Logout?', style: titleRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
          ),



          Divider(height: Dimensions.PADDING_SIZE_EXTRA_SMALL, color: ColorResources.getHint(context)),
          Row(children: [
            Expanded(child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: titleRegular.copyWith(color: ColorResources.getRed(context))),
            )),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: VerticalDivider(width: Dimensions.PADDING_SIZE_EXTRA_SMALL, color: Theme.of(context).hintColor),
            ),
            Expanded(child: TextButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).clearSharedData().then((condition) {
                  Navigator.pop(context);
                  Provider.of<HomeProvider>(context, listen: false).updateHomePageIndex(0);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const AuthScreen()), (route) => false);
                });

              },
              child: Text('Yes', style: titleRegular.copyWith(color: ColorResources.getGreen(context))),
            )),
          ]),

        ]),
      ),
    );
  }
}