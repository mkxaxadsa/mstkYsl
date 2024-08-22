import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/router.dart';
import 'core/config/themes.dart';
import 'features/home/bloc/home_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
