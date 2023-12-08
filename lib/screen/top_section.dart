import 'package:flutter/material.dart';
import 'package:selaras_v01/constants.dart';
import 'package:provider/provider.dart';
import 'search.dart';
import '../services/headset_notifier.dart';
import '../services/call_notifier.dart';

class TopSection extends StatelessWidget {
  final List<dynamic> appData;

  const TopSection({
    Key? key,
    required this.appData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<HeadsetStatusNotifier, CallNotifier>(
      builder: (context, headsetStatus, callStatus, child) {
        String connectStat = callStat(callStatus.receivedMessage);
        String headsetStat = headStat(headsetStatus.isHeadsetConnected);
        return Padding(
          padding: tsOuterPadding(context),
          child: SizedBox(
            height: screenHeight(context, tsHeight),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                searchBox(context),
                showIcon(
                    context, 'C${connectStat}H$headsetStat', tsIconPadding),
                showIcon(context, tsSettingIcon, tsIconPadding),
                showIcon(context, tsJamaahIcon, tsIconPadding),
              ],
            ),
          ),
        );
      },
    );
  }
}
