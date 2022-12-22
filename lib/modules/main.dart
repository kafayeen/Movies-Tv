import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesappokoul/components/components.dart';
import 'package:moviesappokoul/cubit/cubit.dart';
import 'package:moviesappokoul/cubit/states.dart';
import 'package:moviesappokoul/models/nowplaying.dart';
import 'package:moviesappokoul/models/upcomingmodel.dart';
import 'package:moviesappokoul/modules/details.dart';
import 'package:moviesappokoul/shared/constant.dart';

class New extends StatelessWidget {
  const New({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MoviesCubit.get(context);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Trending",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                ConditionalBuilder(
                  condition: cubit.trendingImage.isNotEmpty,
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  builder: (context) => Container(
                      height: 200,
                      width: double.infinity,
                      child: trending(cubit.trendingImage,
                          cubit.nowPlayingModel!, context)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Upcoming Movies",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ConditionalBuilder(
                        condition: cubit.upcomingImage.isNotEmpty,
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                        builder: (context) => Container(
                          height: 130,
                          child: NotificationListener<
                              OverscrollIndicatorNotification>(
                            onNotification: (o) {
                              o.disallowIndicator();
                              return true;
                            },
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => upcoming(
                                  context,
                                  cubit.upcomingImage,
                                  cubit.upcomingModel!,
                                  index),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 5,
                              ),
                              itemCount: cubit.upcomingModel!.result.length,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Now Playing",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ConditionalBuilder(
                  condition: cubit.nowPlayingImage.isNotEmpty &&
                      cubit.mapFavorites.isNotEmpty,
                  builder: (context) => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 13,
                            crossAxisSpacing: 5,
                            childAspectRatio: 1 / 1.48,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return cardOfNewPlaying(context, cubit.nowPlayingImage,
                          index, cubit.nowPlayingModel!, cubit.nowFavorites);
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cubit.nowPlayingModel!.result.length,
                  ),
                  fallback: (context) {
                    return shimmer(itemCount: cubit.nowPlayingImage.length);
                  },
                )
              ],
            ),
          );
        });
  }

  Widget trending(List<Widget> images, NowPlaying model, context) {
    return CarouselSlider(
        items: images.map((e) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Details(
                            id: model.result[images.indexOf(e)].id,
                            imagePoster: e,
                            adult: model.result[images.indexOf(e)].adult,
                            name: model.result[images.indexOf(e)].originalTitle,
                            overview: model.result[images.indexOf(e)].overview,
                            stars: model.result[images.indexOf(e)].id,
                            originalLanguage: model
                                .result[images.indexOf(e)].originalLanguage
                                .toUpperCase(),
                          )));
            },
            child: e,
          );
        }).toList(),
        options: CarouselOptions(
            reverse: false,
            autoPlay: true,
            viewportFraction: 1,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            scrollDirection: Axis.horizontal,
            autoPlayInterval: const Duration(seconds: 3)));
  }

  Widget upcoming(
      context, List<Widget> images, UpcomingModel upcomingModel, int index) {
    return Container(
      width: 120,
      height: 55,
      child: InkWell(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [
                    0,
                    0.7
                  ],
                      colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0.8),
                  ])),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5), child: images[index]),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Details(
                        id: upcomingModel.result[index].id,
                        originalLanguage: upcomingModel
                            .result[index].originalLanguage
                            .toUpperCase(),
                        imagePoster: images[index],
                        adult: upcomingModel.result[index].adult,
                        name: upcomingModel.result[index].originalTitle,
                        overview: upcomingModel.result[index].overview,
                        stars: upcomingModel.result[index].vote,
                      )));
        },
      ),
    );
  }
}
