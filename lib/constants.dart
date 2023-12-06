import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/id_manager.dart';

/// ==================================================================================================
/// Global Variables
/// ==================================================================================================
String deviceID = '';
String wsAddress = 'ws://batman.id:3002';

/// ==================================================================================================
/// Common Functions
/// ==================================================================================================

// --- Daftar fungsi untuk menghitung proporsi layar berdasarkan form factornya
double screenHeight(BuildContext context, double percentage) {
  return MediaQuery.of(context).size.height * (percentage / 100);
}

double screenWidth(BuildContext context, double percentage) {
  return MediaQuery.of(context).size.width * (percentage / 100);
}

double getVRatio(BuildContext context) {
  return screenHeight(context, 1.0);
}

double getHRatio(BuildContext context) {
  return screenWidth(context, 1.0);
}

// Menghitung rasio berdasarkan form terkecil (horiz/vert) dari layar
double getMinARatio(BuildContext context) {
  double rX = screenWidth(context, 1.0);
  double rY = screenWidth(context, 1.0);
  return rX < rY ? rX : rY;
}

// Menghitung rasio berdasarkan form terbesar (horiz/vert) dari layar
double getMaxARatio(BuildContext context) {
  double rX = screenWidth(context, 1.0);
  double rY = screenWidth(context, 1.0);
  return rX > rY ? rX : rY;
}

// Menampilkan icon
Container showIcon(BuildContext context, String iconFile, double padding) {
  return Container(
    alignment: Alignment.center,
    child: Padding(
      padding: EdgeInsets.all(screenWidth(context, padding)),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/$iconFile.svg',
        ),
      ),
    ),
  );
}

// Menampilkan icon dengan width (dalam persen)
Container showIconWidth(
    BuildContext context, String iconFile, double padding, double width) {
  return Container(
    alignment: Alignment.center,
    child: Padding(
      padding: EdgeInsets.all(screenWidth(context, padding)),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/$iconFile.svg',
          width: screenWidth(context, width),
        ),
      ),
    ),
  );
}

// Menampilkan icon dengan size (dalam persen)
Container showIconHeight(
    BuildContext context, String iconFile, double padding, double height) {
  return Container(
    alignment: Alignment.center,
    child: Padding(
      padding: EdgeInsets.all(screenWidth(context, padding)),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/$iconFile.svg',
          fit: BoxFit.contain,
          height: screenHeight(context, height),
        ),
      ),
    ),
  );
}

/// Buat ID jika device baru, atau ambil dari local storage, jika sudah pernah digunakan
/// ID ini akan menetap dan tidab berubah selama aplikasi ini ada.
/// Digunakan juga sebagai unique device ID di dalam database untuk pendaftaran user
Future<void> setupDeviceID() async {
  if (deviceID == '') {
    IdManager idManager = IdManager();
    deviceID = await idManager.getID();
  }
}

/// ==================================================================================================
/// Color Definition
/// ==================================================================================================
const mediumGreen = Color(0xFF03AC0E);
const shadowGreen = Color(0xFF028C0B);
const lightGreen = Color(0xFFEFFAF5);
const strongGray = Color(0xFF595959);
const mediumGray = Color(0xFFAAAAAA);
const mediumOrange = Color(0xFFFCB259);
const shadowRed = Color(0xFF96030C);
const specialTextColor = Color(0xFF7E592C);

/// ==================================================================================================
/// Text Definition
/// ==================================================================================================
TextStyle smallText(BuildContext context, Color color) {
  return GoogleFonts.inter(
    fontSize: 3.2 * getMinARatio(context),
    color: color,
  );
}

TextStyle mediumText(BuildContext context, Color color) {
  return GoogleFonts.inter(
    fontSize: 4.2 * getMinARatio(context),
    fontWeight: FontWeight.w600,
    color: color,
  );
}

TextStyle specialText(BuildContext context) {
  return GoogleFonts.inter(
    fontSize: 3.8 * getMinARatio(context),
    color: specialTextColor,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
  );
}

/// ==================================================================================================
/// Other Common Constants
/// ==================================================================================================
const pi = 3.14159265359;

/// ==================================================================================================
/// Top Section
/// ==================================================================================================
const tsHeight = 4.0; // Tinggi top section dalam persen
const tsSearchColor = lightGreen;
const tsBorderColor = mediumGray;
const tsIconPadding = 1.2; // Padding dalam persen
const tsPadding = 2.5; // Padding luar dari top section dlm persen
const tsSearchBoxRadius = 5.0; // Lengkungan search box dalam persen
const tsSearchHint = 'Pencarian'; // Hint dari search box
const tsSettingIcon = 'setting-icon';
const tsJamaahIcon = 'jamaah-icon';

// Mengatur border dari search box di bagian atas screen
OutlineInputBorder searchBoxBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius:
        BorderRadius.circular(screenWidth(context, tsSearchBoxRadius)),
    borderSide: const BorderSide(
      color: tsBorderColor,
    ),
  );
}

EdgeInsets tsOuterPadding(BuildContext context) {
  return EdgeInsets.all(tsPadding * getMinARatio(context));
}

/// ==================================================================================================
/// Advertisement
/// ==================================================================================================

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
const adDuration = Duration(seconds: 10);
const adPercentageHeight = 20.0;
const adViewportFraction = 0.6;
const adIndicatorWidth = 2.5; // Dalam persen terhadap lebar layar
const adActiveIndicatorWidth = 3.0; // Dalam persen terhadap lebar layar
const adAnimationDuration = Duration(milliseconds: 800);
const adAspectRatio = 16 / 9;

EdgeInsets adPadding(BuildContext context) {
  double rX = getHRatio(context);
  double rY = getVRatio(context);
  return EdgeInsets.only(
      left: 0.4 * rX, right: 0.4 * rX, top: 0.0 * rY, bottom: 0.8 * rY);
}

EdgeInsets adIndicatorSpacing(BuildContext context) {
  double rX = getHRatio(context);
  double rY = getVRatio(context);
  return EdgeInsets.only(
      left: 0.8 * rX, right: 0.8 * rX, top: 0.8 * rY, bottom: 1.2 * rY);
}

BorderRadius adBorderRadius(BuildContext context) {
  return BorderRadius.circular(3.2 * getMinARatio(context));
}

/// ==================================================================================================
/// Interactive Group
/// ==================================================================================================

const igHeight = 60.0; // Tinggi area dalam persen
const igWidth = 100.0; // Lebar area dalam persen
const igBackgroundColor = mediumOrange;
const igInsetPaddingRatio = 1.0; // Lebar pinggiran dalam persen
const igTitleAngle = pi * 3 / 2;
const igTitleBoxSize = 35.0; // Lebar kotak title dalam persen
const igTitleLeftPaddingRatio = 2.5; // Jarak title dari kiri dalam persen
const igIconLeftPaddingRatio = 9.0; // Jarak icon dari kiri dalam persen
const igStatusLeftPaddingRatio = 23.0; // Jarak status dari kiri dalam persen
const igHeadsetLeftPaddingRatio = 60.0; // Jarak headset dari kiri dlm persen
const igIconPadding = 1.2; // Jarak antar icon dalam persen
const igIconWidth = 7.0; // Lebar icon dalam persen
const igHeadsetIconHeight = igSafeAreaHeight - 3.5 * igIconPadding;
const igSafeAreaHeight = igHeight - infoHeight - 2 * igInsetPaddingRatio;
const igIcon1 = 'thawaf-icon';
const igIcon2 = 'sai-icon';
const igIcon3 = 'wisata-icon';
const igIcon4 = 'muthawif-icon';
const igTitleText = 'Grup Interaktif';

EdgeInsetsGeometry igTitleLeftPadding(BuildContext context) {
  return EdgeInsets.only(top: screenWidth(context, igTitleLeftPaddingRatio));
}

double igIconLeftPadding(BuildContext context) {
  return screenWidth(context, igIconLeftPaddingRatio);
}

double igStatusLeftPadding(BuildContext context) {
  return screenWidth(context, igStatusLeftPaddingRatio);
}

double igHeadsetLeftPadding(BuildContext context) {
  return screenWidth(context, igHeadsetLeftPaddingRatio);
}

double igTitleBoxWidth(BuildContext context) {
  return screenWidth(context, igTitleBoxSize);
}

double igTitleBoxHeight(BuildContext context) {
  return screenHeight(context, igTitleBoxSize);
}

EdgeInsetsGeometry igInsetPadding(BuildContext context) {
  return EdgeInsets.all(screenHeight(context, igInsetPaddingRatio));
}

SizedBox igStatusJarak(BuildContext context) {
  return SizedBox(
    height: screenHeight(context, 2.0),
  );
}

List<Widget> igStatusText(
    BuildContext context, String connect, String headset) {
  if (connect == 'N' && headset == 'N') {
    return [
      Text(
        'Mohon siapkan\nheadset Anda',
        style: mediumText(context, strongGray),
      ),
    ];
  } else if (connect == 'N' && headset == 'Y') {
    return [
      Text(
        'Headset Anda\ntelah terpasang',
        style: mediumText(context, strongGray),
      ),
      igStatusJarak(context),
      Text(
        'Menunggu panggilan',
        style: mediumText(context, strongGray),
      ),
    ];
  } else if (connect == 'D' && headset == 'N') {
    return [
      Text(
        'PANGGILAN\nMASUK ...',
        style: mediumText(context, shadowRed),
      ),
      igStatusJarak(context),
      Text(
        'Pasang headset\nAnda SEKARANG',
        style: mediumText(context, strongGray),
      ),
    ];
  } else if (connect == 'D' && headset == 'Y') {
    return [
      Text(
        'PANGGILAN\nMASUK ...',
        style: mediumText(context, shadowRed),
      ),
    ];
  } else {
    return [];
  }
}

String igHeadsetIconFile(String connect, String headset) {
  if (connect == 'N' && headset == 'N') {
    return 'headset-off';
  } else if (connect == 'N' && headset == 'Y') {
    return 'headset-connect';
  } else if (connect == 'D' && headset == 'N') {
    return 'headset-disconnect';
  } else if (connect == 'D' && headset == 'Y') {
    return 'headset-connect';
  } else {
    return '';
  }
}

/// ==================================================================================================
/// Info Section
/// ==================================================================================================

const infoHeight = 40.0; // Tinggi area dalam persen
const infoTopPosition = 20.0; // Posisi dari atas, setelah iklan (dalam persen)
const infoTopRadiusRatio = 10.0; // Radius lengkungan di kiri dan kanan (%)
const infoBackgroundColor = lightGreen;

Radius infoTopRadius(BuildContext context) {
  return Radius.circular(getMinARatio(context) * infoTopRadiusRatio);
}
