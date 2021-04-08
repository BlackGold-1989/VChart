import 'package:flutter/material.dart';

class NavigationService {

  void navigateToScreen(
      BuildContext context,
      Widget screen, {
        bool replace = false,
        String routeParams,
        String routeIdentifier,
        Function(dynamic) navigatorPop,
        Map<String, dynamic> args,
      }) async
  {
    if (replace) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<Object>(
          builder: (context) => screen,
        ),
      ).then((value) => {
        if (navigatorPop != null) navigatorPop(value)
      });
    } else {
      Navigator.of(context).push(
        MaterialPageRoute<Object>(
          builder: (context) => screen,
        ),
      ).then((value) => {
        if (navigatorPop != null) navigatorPop(value)
      });
    }
  }

  void pop(BuildContext context, {dynamic data}) async {
    Navigator.of(context).pop<dynamic>(data);
  }

}
