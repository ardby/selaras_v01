import 'package:flutter/material.dart';
import '../top_section.dart';
import '../ad_section.dart';
import '../interactive_group.dart';

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
  late AnimationController _controller;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.appData.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            TopSection(appData: widget.appData),
            const AdSlider(),
            InteractiveGroup(appData: widget.appData),
          ],
        );
      },
    );
  }
}
