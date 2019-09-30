import 'package:flutter/material.dart';

class RotaCikisYolu<T> extends MaterialPageRoute<T> {
  RotaCikisYolu({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(opacity: animation, child: child);
  }
}