import 'package:flutter/material.dart';
import 'package:selaras_v01/constants.dart';

class InteractiveGroup extends StatelessWidget {
  final List<dynamic> appData;

  const InteractiveGroup({
    Key? key,
    required this.appData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: igInsetPadding(context),
      width: screenWidth(context, igWidth),
      height: screenHeight(context, igHeight),
      color: igBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: screenWidth(context, igWidth),
          height: screenHeight(
              context, igHeight - infoHeight - 2 * igInsetPaddingRatio),
          child: Stack(
            children: [
              SizedBox(
                width: igTitleBoxWidth(context),
                height: igTitleBoxWidth(context),
                child: Transform.rotate(
                  angle: igTitleAngle,
                  child: Container(
                    padding: igTitleLeftPadding(context),
                    alignment: Alignment.topCenter,
                    child: Text(
                      igTitleText,
                      style: specialText(context),
//                          textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: igIconLeftPadding(context),
                top: 0.0,
                child: Column(
                  children: [
                    showIconWidth(context, igIcon1, igIconPadding, igIconWidth),
                    showIconWidth(context, igIcon2, igIconPadding, igIconWidth),
                    showIconWidth(context, igIcon3, igIconPadding, igIconWidth),
                    showIconWidth(context, igIcon4, igIconPadding, igIconWidth),
                  ],
                ),
              ),
              Positioned(
                left: igStatusLeftPadding(context),
                top: 0.0,
                child: Container(
                  alignment: Alignment.center,
//                  color: Colors.green,
                  height: screenHeight(
                      context, igHeight - infoHeight - 2 * igInsetPaddingRatio),
                  child: Text(
                    'Mohon siapkan\nheadset Anda',
                    style: mediumText(context, strongGray),
                  ),
                ),
              ),
              Positioned(
                left: igHeadsetLeftPadding(context),
                top: 0.0,
                child: Container(
                    height: screenHeight(context,
                        igHeight - infoHeight - 2 * igInsetPaddingRatio),
                    alignment: Alignment.center,
                    child: showIcon(
                        context, 'headset-off', topSectionIconPadding)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
