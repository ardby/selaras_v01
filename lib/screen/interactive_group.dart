import 'package:flutter/material.dart';
import 'package:selaras_v01/constants.dart';
import '../services/headset_notifier.dart';
import '../services/call_notifier.dart';
import 'package:provider/provider.dart';

class InteractiveGroup extends StatelessWidget {
  final List<dynamic> appData;

  const InteractiveGroup({
    Key? key,
    required this.appData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<HeadsetStatusNotifier, CallNotifier>(
      builder: (context, headsetStatus, callStatus, child) {
        String connectStat = 'N'; // Akan ditambah consumer untuk connection
        if (callStatus.receivedMessage.toLowerCase() == "call") {
          connectStat = 'D';
        }
        if (callStatus.receivedMessage.toLowerCase() == "end") {
          connectStat = 'N';
        }
        String headsetStat = headsetStatus.isHeadsetConnected ? 'Y' : 'N';
        return Container(
          padding: igInsetPadding(context),
          width: screenWidth(context, igWidth),
          height: screenHeight(context, igHeight),
          color: igBackgroundColor,
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: screenWidth(context, igWidth),
              height: screenHeight(context, igSafeAreaHeight),
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
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: igIconLeftPadding(context),
                    top: 0.0,
                    child: Column(
                      children: [
                        showIconWidth(
                            context, igIcon1, igIconPadding, igIconWidth),
                        showIconWidth(
                            context, igIcon2, igIconPadding, igIconWidth),
                        showIconWidth(
                            context, igIcon3, igIconPadding, igIconWidth),
                        showIconWidth(
                            context, igIcon4, igIconPadding, igIconWidth),
                      ],
                    ),
                  ),
                  Positioned(
                    left: igStatusLeftPadding(context),
                    top: 0.0,
                    child: SizedBox(
                      height: screenHeight(context, igSafeAreaHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            igStatusText(context, connectStat, headsetStat),
                      ),
                    ),
                  ),
                  Positioned(
                    left: igHeadsetLeftPadding(context),
                    top: 0.0,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: showIconHeight(
                          context,
                          igHeadsetIconFile(connectStat, headsetStat),
                          igIconPadding,
                          igHeadsetIconHeight),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
