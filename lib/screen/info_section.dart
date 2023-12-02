import 'package:flutter/material.dart';
import 'package:selaras_v01/constants.dart';

class InfoSection extends StatefulWidget {
  List<dynamic> appData;

  InfoSection({
    Key? key,
    required this.appData,
  }) : super(key: key);

  @override
  State<InfoSection> createState() => _InfoSectionState();
}

class _InfoSectionState extends State<InfoSection> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0.0,
      top: screenHeight(context, infoTopPosition),
      child: Container(
        width: screenWidth(context, 100), // Memenuhi layar secara horizontal
        height: screenHeight(context, infoHeight),
        decoration: BoxDecoration(
          color: infoBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: infoTopRadius(context),
            topRight: infoTopRadius(context),
          ),
        ),
      ),
    );
  }
}
