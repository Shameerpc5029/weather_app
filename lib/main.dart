

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/common/style/colors.dart';
import 'package:weather_app/search/controller/history_controller.dart';
import 'package:weather_app/search/model/seach_model.dart';
import 'package:weather_app/splash/controller/splash_controller.dart';
import 'package:weather_app/splash/view/splash_screen.dart';

import 'home/controller/home_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(HistoryModelAdapter().typeId)) {
    Hive.registerAdapter(HistoryModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashController()),
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => HistoryService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
          textTheme: const TextTheme().copyWith(
            bodyMedium: TextStyle(
              color: AppColor().kTextColor,
            ),
            bodySmall: TextStyle(
              color: AppColor().kTextColor,
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(158, 3, 40, 105),
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
