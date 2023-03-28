import 'package:event_bus_plus/res/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/repo/api_repo.dart';
import 'package:weather_app/screens/homescreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white12),
      home: BlocProvider(
        create: (context) => WeatherBloc(WeatherRepo()),
        child: const HomeScreen(),
      ),
    );
  }
}
