import 'package:flutter/material.dart';
import 'package:mswm_test/common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<int> mycoins = ValueNotifier(100);
ValueNotifier<int> mydiamonds = ValueNotifier(0);

Future<void> getData() async {
  final prefs = await SharedPreferences.getInstance();
  // await prefs.remove('onboard');
  mycoins.value = prefs.getInt(SharedData.coins) ?? 100;
  mydiamonds.value = prefs.getInt(SharedData.diamonds) ?? 0;
}

Future<void> saveData() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('onboard', false);
}

int getCurrentTimestamp() {
  return DateTime.now().millisecondsSinceEpoch ~/ 1000;
}

// final List<String> assets = [
//   'assets/bg1.png',
//   'assets/bg2.png',
//   'assets/bg3.png',
//   'assets/bg4.png',
//   'assets/bg5.png',
//   'assets/bg6.png',
//   'assets/bg7.png',
//   'assets/bg8.png',
//   'assets/bg9.png',
// ];

// final List<String> assets2 = [
//   'assets/bg10.png',
//   'assets/bg11.png',
//   'assets/bg12.png',
//   'assets/bg13.png',
//   'assets/bg14.png',
//   'assets/bg15.png',
//   'assets/bg16.png',
//   'assets/bg17.png',
//   'assets/bg18.png',
//   'assets/bg19.png',
// ];

Future<void> minusCoins(int amount) async {
  final prefs = await SharedPreferences.getInstance();
  mycoins.value -= amount;
  prefs.setInt(SharedData.coins, mycoins.value);
}

Future<void> addCoins(int amount) async {
  final prefs = await SharedPreferences.getInstance();
  mycoins.value += amount;
  prefs.setInt(SharedData.coins, mycoins.value);
}

Future<void> minusDiamonds(int amount) async {
  final prefs = await SharedPreferences.getInstance();
  mydiamonds.value -= amount;
  prefs.setInt(SharedData.diamonds, mydiamonds.value);
}

Future<void> addDiamonds(int amount) async {
  final prefs = await SharedPreferences.getInstance();
  mydiamonds.value += amount;
  prefs.setInt(SharedData.diamonds, mydiamonds.value);
}

Future<DateTime?> getTimeDiamonds() async {
  final prefs = await SharedPreferences.getInstance();
  String? time = prefs.getString(SharedData.diamondsTime);
  var dateTime = DateTime.tryParse(time ?? "");
  return dateTime;
}

Future<DateTime?> getTimeDailyRewards() async {
  final prefs = await SharedPreferences.getInstance();
  String? time = prefs.getString(SharedData.daily);
  var dateTime = DateTime.tryParse(time ?? "");
  return dateTime;
}

Future<DateTime?> setTimeDailyRewards({String? time}) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(SharedData.daily,
      time ?? DateTime.now().add(Duration(hours: 24)).toIso8601String());
  var dateTime = DateTime.tryParse(time ?? "");
  return dateTime;
}

Future<DateTime?> setTimeDiamonds({String? time}) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(
      SharedData.diamondsTime, time ?? DateTime.now().toIso8601String());
  var dateTime = DateTime.tryParse(time ?? "");
  return dateTime;
}

// void precache(BuildContext context) async {
//   for (String asset in asset) {
//     await precacheImage(AssetImage(asset), context);
//   }
// }

double getStatusBar(BuildContext context) {
  return MediaQuery.of(context).viewPadding.top;
}

double getBottom(BuildContext context) {
  return MediaQuery.of(context).viewPadding.bottom;
}
