import 'package:flutter/material.dart';

class InteractiveGroup extends StatefulWidget {
  List<dynamic> appData;

  InteractiveGroup({
    Key? key,
    required this.appData,
  }) : super(key: key);

  @override
  State<InteractiveGroup> createState() => _InteractiveGroupState();
}

class _InteractiveGroupState extends State<InteractiveGroup> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
