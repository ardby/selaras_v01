import 'package:flutter/material.dart';
import 'top_section.dart';
import 'ad_section.dart';
import 'interactive_group.dart';

class ScreenLayout extends StatefulWidget {
  final List<dynamic> appData;

  const ScreenLayout({
    Key? key,
    required this.appData,
  }) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TopSection(appData: widget.appData),
        const AdSlider(),
        InteractiveGroup(appData: widget.appData),
      ],
    );
  }
}
