import 'package:flutter/material.dart';

class Routes {
  static Routes routesInstance = Routes();

  Future<dynamic> pushandRemoveUntil(
    Widget widget,
    BuildContext context,
  ) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => widget),
      (route) => false,
    );
  }
  // Old Function Without Required Parameters //
  // Future<dynamic> push(widget, BuildContext context) {
  //   return Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => widget,
  //   ));
  // }

  // New Function With Required Parameters //
  Future<dynamic> push(
      {required Widget widget, required BuildContext context}) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }
}
