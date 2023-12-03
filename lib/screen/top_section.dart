import 'package:flutter/material.dart';
import 'package:selaras_v01/constants.dart';
import '../services/headset_notifier.dart';
import 'package:provider/provider.dart';

class TopSection extends StatelessWidget {
  final List<dynamic> appData;

  const TopSection({
    Key? key,
    required this.appData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HeadsetStatusNotifier>(
        builder: (context, headsetStatus, child) {
      return Padding(
        padding: topSectionOuterPadding(context),
        child: SizedBox(
          height: screenHeight(context, topSectionHeight),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  style: smallText(context, strongGray),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: topSectionSearchHint,
                    hintStyle: smallText(context, mediumGray),
                    focusColor: strongGray,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    isDense: true,
                    enabledBorder: searchBoxBorder(context),
                    focusedBorder: searchBoxBorder(context),
                    filled: true,
                    fillColor: topSectionSearchColor,
                    prefixIcon: const CustomSearchIcon(),
                  ),
                ),
              ),
              showIcon(
                  context,
                  headsetStatus.isHeadsetConnected ? 'CNHY' : 'CNHN',
                  topSectionIconPadding),
              showIcon(context, 'setting-icon', topSectionIconPadding),
              showIcon(context, 'jamaah-icon', topSectionIconPadding),
            ],
          ),
        ),
      );
    });
  }
}

class CustomSearchIcon extends StatefulWidget {
  const CustomSearchIcon({super.key});

  @override
  CustomSearchIconState createState() => CustomSearchIconState();
}

class CustomSearchIconState extends State<CustomSearchIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: IconButton(
        icon: const Icon(Icons.search),
        padding: EdgeInsets.all(0.0),
        iconSize: 4 * getMinARatio(context),
        alignment: Alignment.center,
        onPressed: () {
          // Handle search button press
        },
        color: isHovered ? strongGray : mediumGray,
      ),
    );
  }
}
