import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesappokoul/cubit/cubit.dart';
import 'package:moviesappokoul/cubit/states.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
        builder: (context, state) {
          var cubit = MoviesCubit.get(context);
          return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.black,
                title: Text(
                  cubit.appBar[cubit.currentIndex],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.black,
                currentIndex: cubit.currentIndex,
                onTap: (v) {
                  cubit.changeIndex(v);
                },
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.movie), label: "Movies"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.rate_review), label: "Top Rated"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "Favorites"),
                ]),
          );
        },
        listener: (context, state) {});
  }
}
