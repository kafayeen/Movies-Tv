import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviesappokoul/cubit/cubit.dart';
import 'package:moviesappokoul/cubit/states.dart';
import 'package:moviesappokoul/models/upcomingmodel.dart';
import 'package:shimmer/shimmer.dart';

class Details extends StatelessWidget {
  dynamic stars;
  String name;
  String overview;
  bool adult;
  String originalLanguage;
  int id;

  Widget imagePoster;

  Details(
      {required this.imagePoster,
      required this.name,
      required this.stars,
      required this.adult,
      required this.overview,
      required this.originalLanguage,
      required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        MoviesCubit.get(context).getBudget(id: id.toString());
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title: const Text(
              "Details",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity, height: 300, child: imagePoster),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    alignment: Alignment.center,
                    child: RatingBar.builder(
                      initialRating: stars / 2,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemSize: 25,
                      itemCount: 5,
                      unratedColor: Colors.white,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      child: button(function: () {}, text: originalLanguage),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 50,
                      child: button(
                          function: () {},
                          text: "Adult",
                          color: adult == true ? Colors.green : Colors.red),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    overview,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ConditionalBuilder(
                  condition: MoviesCubit.get(context).budget != null,
                  fallback: (context) => Center(
                    child: Shimmer.fromColors(
                        child: Text("Budget",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        baseColor: Colors.white,
                        highlightColor: Colors.grey),
                  ),
                  builder: (context) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (MoviesCubit.get(context).budget!.budget != 0)
                        Text(
                          "Budget : ${MoviesCubit.get(context).budget!.budget} \$",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget button(
      {required Function() function,
      required String text,
      Color color = const Color.fromARGB(255, 80, 79, 79)}) {
    return Container(
      width: 170,
      height: 50,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(25)),
      child: MaterialButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
