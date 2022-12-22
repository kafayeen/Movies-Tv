import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesappokoul/cubit/cubit.dart';
import 'package:moviesappokoul/cubit/states.dart';
import 'package:moviesappokoul/modules/splash.dart';
import 'package:moviesappokoul/shared/blocobserver.dart';
import 'package:moviesappokoul/shared/network/remote.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesCubit()
        ..getPopular()
        ..getUpcoming()
        ..getNowPlaying(),
      child: BlocConsumer<MoviesCubit, MoviesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: "Movies App",
            theme: ThemeData(scaffoldBackgroundColor: Colors.black),
            debugShowCheckedModeBanner: false,
            home: const Splash(),
          );
        },
      ),
    );
  }
}
