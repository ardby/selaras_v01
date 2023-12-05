import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:selaras_v01/constants.dart';

class AdSlider extends StatefulWidget {
  const AdSlider({super.key});

  @override
  State<StatefulWidget> createState() => _AdLayoutState();
}

class _AdLayoutState extends State<AdSlider> {
  int currentAd = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: screenHeight(context, adPercentageHeight),
            autoPlay: true,
            autoPlayInterval: adDuration,
            enlargeCenterPage: true,
            viewportFraction: adViewportFraction,
            aspectRatio: adAspectRatio,
            clipBehavior: Clip.hardEdge,
            onPageChanged: (index, reason) {
              setState(() {
                currentAd = index;
              });
            },
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: adAnimationDuration,
          ),
          items: adList.map((image) {
            return Container(
              margin: adPadding(context),
              decoration: BoxDecoration(
                borderRadius: adBorderRadius(context),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
        DotsIndicator(
          dotsCount: adList.length,
          position: currentAd,
          decorator: DotsDecorator(
            size: Size.square(screenWidth(context, adIndicatorWidth)),
            activeSize:
                Size.square(screenWidth(context, adActiveIndicatorWidth)),
            color: adIndicatorColor, // Inactive color
            activeColor: adActiveIndicatorColor,
            spacing: adIndicatorSpacing(context),
          ),
        ),
      ],
    );
  }
}
