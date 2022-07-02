import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget implements AutoRouteWrapper {
  const SettingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
