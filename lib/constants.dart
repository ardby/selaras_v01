import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

// ==================================================================================================
// Common Functions
// ==================================================================================================

// --- Daftar fungsi untuk menghitung proporsi layar berdasarkan form factornya
double screenHeight(BuildContext context, double percentage) {
  return MediaQuery.of(context).size.height * (percentage / 100);
}

double screenWidth(BuildContext context, double percentage) {
  return MediaQuery.of(context).size.width * (percentage / 100);
}

double getVRatio(BuildContext context) {
  return screenHeight(context, 0.1);
}

double getHRatio(BuildContext context) {
  return screenWidth(context, 0.1);
}

// Menghitung rasio berdasarkan form terkecil (horiz/vert) dari layar
double getMinARatio(BuildContext context) {
  double rX = screenWidth(context, 0.1);
  double rY = screenWidth(context, 0.1);
  return rX < rY ? rX : rY;
}

// Menghitung rasio berdasarkan form terbesar (horiz/vert) dari layar
double getMaxARatio(BuildContext context) {
  double rX = screenWidth(context, 0.1);
  double rY = screenWidth(context, 0.1);
  return rX > rY ? rX : rY;
}

// ----------------------------------------------------------------------------

// ==================================================================================================
// Color Definition
// ==================================================================================================
const mediumGreen = Color(0xFF03AC0E);
const mediumGray = Color(0xFFD6D6D6);
const lightGreen = Color(0xFFEFFAF5);
const mediumOrange = Color(0xFFFCB259);

// ==================================================================================================
// Text Definition
// ==================================================================================================
TextStyle smallText(BuildContext context) {
  return GoogleFonts.inter(fontSize: 32 * getMinARatio(context));
}

// ==================================================================================================
// Top Section
// ==================================================================================================
const topSectionHeight = 4.0; // Tinggi top section dalam persen
const topSectionSearchColor = lightGreen;
const topSectionIconPadding = 1.2; // Padding dalam persen
const topSectionPadding = 20.0; // Padding luar dari top section dlm persen

// Mengatur border dari search box di bagian atas screen
OutlineInputBorder searchBoxBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(20.0),
  borderSide: const BorderSide(
    color: Color(0xFFD6D6D6),
  ),
);

// Menampilkan icon di bagian atas screen, sejajar dengan search box
Container topSectionIcon(BuildContext context, String iconFile) {
  return Container(
    alignment: Alignment.center,
    child: Padding(
      padding: EdgeInsets.all(screenWidth(context, topSectionIconPadding)),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/$iconFile.svg',
        ),
      ),
    ),
  );
}

EdgeInsets topSectionOuterPadding(BuildContext context) {
  return EdgeInsets.all(topSectionPadding * getMinARatio(context));
}

// ==================================================================================================
// Advertisement
// ==================================================================================================

// Daftar URL dari gambar iklan -> link harus langsung ke imagenya
final List<String> adList = [
  'https://storage.googleapis.com/muslimpergi/uploads/article/pict/17201/2.png',
  'https://asset.kompas.com/crops/N4lFRg33FsCqcjovWX1JLS-ZDcI=/0x0:780x520/750x500/data/photo/2021/07/12/60eb956f95b17.png',
  'https://amalsholeh-s3.imgix.net/cover/X5CFk2O5esIZ866sexJb5bTjN9uehFd2oBN9XVJr.jpg?w=690&fit=crop&auto=format,compress',
  'https://digizakat.sgp1.digitaloceanspaces.com/Campaign/473/image/medium/Iklan%20Qurban%20Zakatkita%20digizakat.jpg',
  'https://news.unismuh.ac.id/wp-content/uploads/2022/09/ad238526-dc40-4a91-8f61-e072b92ef0b3.jpg',
];

const adIndicatorColor = mediumGray;
const adActiveIndicatorColor = mediumGreen;
const adDuration = Duration(seconds: 3);
const adPercentageHeight = 25.0;
const adIndicatorWidth = 3.0; // Dalam persen terhadap lebar layar
const adActiveIndicatorWidth = 3.5; // Dalam persen terhadap lebar layar
const adAnimationDuration = Duration(milliseconds: 800);
const adAspectRatio = 16 / 9;

EdgeInsets adPadding(BuildContext context) {
  double rX = getHRatio(context);
  double rY = getVRatio(context);
  return EdgeInsets.only(
      left: 4 * rX, right: 4 * rX, top: 0 * rY, bottom: 8 * rY);
}

EdgeInsets adIndicatorSpacing(BuildContext context) {
  double rX = getHRatio(context);
  double rY = getVRatio(context);
  return EdgeInsets.only(
      left: 8 * rX, right: 8 * rX, top: 8 * rY, bottom: 12 * rY);
}

BorderRadius adBorderRadius(BuildContext context) {
  return BorderRadius.circular(32 * getMinARatio(context));
}
