import 'package:flutter/material.dart';
import 'package:selaras_v01/constants.dart';

class TopSection extends StatelessWidget {
  final List<dynamic> appData;

  const TopSection({
    Key? key,
    required this.appData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: topSectionOuterPadding(context),
      child: SizedBox(
        height: screenHeight(context, topSectionHeight),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                style: smallText(context),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: 'Pencarian',
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  isDense: true,
                  enabledBorder: searchBoxBorder,
                  focusedBorder: searchBoxBorder,
                  filled: true,
                  fillColor: topSectionSearchColor,
                  prefixIcon: const CustomSearchIcon(),
                ),
              ),
            ),
            showIcon(context, 'CNHN', topSectionIconPadding),
            showIcon(context, 'setting-icon', topSectionIconPadding),
            showIcon(context, 'jamaah-icon', topSectionIconPadding),
          ],
        ),
      ),
    );
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
        onPressed: () {
          // Handle search button press
        },
        color: isHovered ? mediumGray : Colors.black, // Atur warna sesuai hover
      ),
    );
  }
}
