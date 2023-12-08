import 'package:flutter/material.dart';
import 'package:selaras_v01/constants.dart';

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
        padding: const EdgeInsets.all(0.0),
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

Expanded searchBox(BuildContext context) {
  return Expanded(
    child: TextField(
      style: smallText(context, strongGray),
      textAlignVertical: TextAlignVertical.center,
      decoration: searchboxDecoration(context),
    ),
  );
}

InputDecoration searchboxDecoration(BuildContext context) {
  return InputDecoration(
    hintText: tsSearchHint,
    hintStyle: smallText(context, mediumGray),
    focusColor: strongGray,
    contentPadding: const EdgeInsets.symmetric(vertical: 0),
    isDense: true,
    enabledBorder: searchBoxBorder(context),
    focusedBorder: searchBoxBorder(context),
    filled: true,
    fillColor: tsSearchColor,
    prefixIcon: const CustomSearchIcon(),
  );
}
