import 'package:flutter/material.dart';
import 'package:selaras_v01/constants.dart';

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
    return Container(
      padding: igInsetPadding(context),
      width: screenWidth(context, igWidth),
      height: screenHeight(context, igHeight),
      color: igBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: screenWidth(context, igWidth),
          height: screenHeight(
              context, igHeight - infoHeight - 2 * igInsetPaddingRatio),
//          color: Colors.blue,
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: screenWidth(context, 35.0),
                    height: screenHeight(context, 35.0),
//                    color: Colors.green,
                    child: Transform.rotate(
                      angle: 3.14159265359 / 2 * 3,
                      child: Container(
                        padding: EdgeInsets.only(top: 10.0),
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Grup Interaktif',
                          style: specialText(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 32.0,
                    top: 4.0,
                    child: Column(
                      children: [
                        showIconWidth(context, 'thawaf-icon', 1.2, 8.0),
                        showIconWidth(context, 'sai-icon', 1.2, 8.0),
                        showIconWidth(context, 'wisata-icon', 1.2, 8.0),
                        showIconWidth(context, 'muthawif-icon', 1.2, 8.0),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Transform.rotate(
// angle: 3.14159265359 / 2 * 3,
// child: Container(
// color: Colors.blue,
// child: Text(
// 'Grup Interaktif',
// style: specialText(context),
// ),
// ),
// ),
